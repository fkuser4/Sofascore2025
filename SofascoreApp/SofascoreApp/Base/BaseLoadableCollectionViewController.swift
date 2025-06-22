//
//  BaseLoadableCollectionViewController.swift
//  SofascoreApp
//
//  Created by Filip Kušer on 17.06.2025..
//
import UIKit
import SofaAcademic
import SnapKit

class BaseLoadableCollectionViewController<ViewModel: LoadableViewModel, DataItem>: UIViewController, BaseViewProtocol {
  internal let viewModel: ViewModel
  internal var dataItems: [DataItem] = []

  private var workItem: DispatchWorkItem?
  private let activityIndicator = UIActivityIndicatorView(style: .medium)
  private let apiErrorView = EmptyStateView()

  var emptyDataView: UIView {
    let view = EmptyStateView()
    view.setMessageText("No data available")
    return view
  }

  internal lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("Use init(viewModel:)")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    addViews()
    styleViews()
    setupConstraints()
    bindViewModel()
    loadData()
  }

  internal func loadData() {
    viewModel.loadData()
  }

  private func setupCollectionView() {
    registerCells()
    configureLayout()
  }

  private func bindViewModel() {
    viewModel.onStateChange = { [weak self] state in
      self?.handleStateChange(state)
    }
  }

  private func handleStateChange(_ state: LoadingState<ViewModel.DataType>) {
    switch state {
    case .idle:
      hideAllViews()
    case .loading:
      showLoading()

    case .loaded(let data):
      showData(data)

    case .error(let error):
      showError(error)
    }
  }

  private func hideAllViews() {
    collectionView.backgroundView = nil
    collectionView.isHidden = true
    activityIndicator.stopAnimating()
  }

  private func showLoading() {
    collectionView.backgroundView = nil
    collectionView.isHidden = true

    workItem?.cancel()

    let newWorkItem = DispatchWorkItem { [weak self] in
      DispatchQueue.main.async {
        self?.activityIndicator.startAnimating()
      }
    }

    workItem = newWorkItem
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: newWorkItem)
  }

  private func showData(_ data: ViewModel.DataType) {
    workItem?.cancel()
    activityIndicator.stopAnimating()

    handleDataLoaded(data)

    if dataItems.isEmpty {
      collectionView.isHidden = false
      collectionView.backgroundView = emptyDataView
    } else {
      collectionView.isHidden = false
      collectionView.backgroundView = nil
    }

    collectionView.reloadData()
  }

  private func showError(_ error: Error) {
    workItem?.cancel()
    activityIndicator.stopAnimating()

    collectionView.isHidden = false
    dataItems.removeAll()
    collectionView.reloadData()
    apiErrorView.setMessageText(error.localizedDescription)
    collectionView.backgroundView = apiErrorView
  }

  func registerCells() {
    fatalError("Override registerCells() in subclass")
  }

  func configureLayout() {
    fatalError("Override configureLayout() in subclass")
  }

  func handleDataLoaded(_ data: ViewModel.DataType) {
    fatalError("Override handleDataLoaded(_:) in subclass")
  }

  func addViews() {
    view.addSubview(collectionView)
    view.addSubview(activityIndicator)
  }

  func styleViews() {
    view.backgroundColor = .contentBackground
    collectionView.backgroundColor = .clear
  }

  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    activityIndicator.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}
