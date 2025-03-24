//
//  FootballEventsViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 24.03.2025..
//
import UIKit
import SnapKit
import SofaAcademic

final class FootballEventsViewController: UIViewController {
    
    private var allEvents: [Event] = []
    private var currentEvents: [League: [Event]] = [:]
    private var displayedLeagues: [League] = []
    private let dataSource = Homework3DataSource()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier)
        collectionView.register(
            LeagueHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: LeagueHeaderCollectionReusableView.reuseIdentifier
        )
        collectionView.register(
            SectionDividerView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: SectionDividerView.reuseIdentifier
        )
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadData()
        setupSubviews()
        setupConstraints()
    }
    
    private func loadData() {
        allEvents = dataSource.events()
        updateCurrentEvents()
    }
    
    private func updateCurrentEvents() {
        currentEvents = [:]
        displayedLeagues = []
        
        for event in allEvents {
            guard let league = event.league else { continue }
            if var leagueEvents = currentEvents[league] {
                leagueEvents.append(event)
                currentEvents[league] = leagueEvents
            } else {
                currentEvents[league] = [event]
                displayedLeagues.append(league)
            }
        }
        displayedLeagues.sort { $0.name < $1.name }
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.createSectionLayout()
        }
    }
    
    private func createSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(56)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(56)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(56)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(1)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        section.boundarySupplementaryItems = [header, footer]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
        
        return section
    }
}

extension FootballEventsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return displayedLeagues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < displayedLeagues.count else { return 0 }
        let league = displayedLeagues[section]
        return currentEvents[league]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard indexPath.section < displayedLeagues.count,
              let events = currentEvents[displayedLeagues[indexPath.section]],
              indexPath.item < events.count else {
            return cell
        }
        
        let event = events[indexPath.item]
        cell.configure(with: EventViewModel(event: event))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: LeagueHeaderCollectionReusableView.reuseIdentifier,
                for: indexPath
            ) as? LeagueHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            guard indexPath.section < displayedLeagues.count else { return headerView }
            let league = displayedLeagues[indexPath.section]
            headerView.configure(with: LeagueHeaderViewModel(league: league))
            return headerView
            
        } else if kind == UICollectionView.elementKindSectionFooter {
            guard let divider = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionDividerView.reuseIdentifier,
                for: indexPath
            ) as? SectionDividerView else {
                return UICollectionReusableView()
            }
            
            return divider
        }
        
        return UICollectionReusableView()
    }
}
