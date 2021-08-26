import Foundation
import UIKit

//MARK:--- MJRefreshAutoFooter 重设置 ----------
public extension Bee where Base: MJRefreshFooter {
    /// 忽略多少scrollView的contentInset的bottom
    @discardableResult
    func ignoredContentInsetBottom(_ t:CGFloat = 0) -> Bee {
        base.ignoredScrollViewContentInsetBottom = t
        return self
    }
}

//MARK:--- MJRefreshAutoFooter 重设置 ----------
public extension Bee where Base: MJRefreshAutoFooter {
    /// 是否自动刷新
    @discardableResult
    func isAutoRefresh(_ t:Bool = true) -> Bee {
        base.isAutomaticallyRefresh = t
        return self
    }
    /// 当底部控件出现多少时就自动刷新
    @discardableResult
    func autoRefreshPercent(_ t:CGFloat = 1.0) -> Bee {
        base.triggerAutomaticallyRefreshPercent = t
        return self
    }
}
//MARK:--- MJRefreshBackNormalFooter 重设置 ----------
public extension Bee where Base: MJRefreshBackNormalFooter {
    var activityStyle: UIActivityIndicatorView.Style {
        set{
            base.loadingView?.style = newValue
        }
        get{
            return base.loadingView?.style ?? .gray
        }
    }
    /// 设置菊花样式
    @discardableResult
    func activityStyle(_ style: UIActivityIndicatorView.Style = .gray) -> Bee {
        base.loadingView?.style = style
        return self
    }
}
//MARK:--- MJRefreshAutoNormalFooter 重设置 ----------
public extension Bee where Base: MJRefreshAutoNormalFooter {
    var activityStyle:UIActivityIndicatorView.Style {
        set{
            base.loadingView?.style = newValue
        }
        get{
            return base.loadingView?.style ?? .gray
        }
    }
    /// 设置菊花样式
    @discardableResult
    func activityStyle(_ style: UIActivityIndicatorView.Style = .gray) -> Bee {
        base.loadingView?.style = style
        return self
    }

}
//MARK:--- MJRefreshBackStateFooter 重设置 ----------
public extension Bee where Base: MJRefreshBackStateFooter {
    /// 设置文字
    @discardableResult
    func setTitle(isHidden:Bool = true,
                  font:UIFont = UIFont.systemFont(ofSize: 14),
                  color:UIColor = UIColor.gray,
                  inset:CGFloat = 0,
                  title:[RefreshModel.TitlesEnum] = [.idle(""),
                                                          .pulling(""),
                                                          .refreshing(""),
                                                          .willRefresh(""),
                                                          .noMoreData("")]
        ) -> Bee
    {
        base.stateLabel?.isHidden = isHidden
        guard !isHidden else {
            return self
        }
        for item in title {
            switch item {
            case .idle(let t):
                base.setTitle(t, for: .idle)
            case .pulling(let t):
                base.setTitle(t, for: .pulling)
            case .refreshing(let t):
                base.setTitle(t, for: .refreshing)
            case .willRefresh(let t):
                base.setTitle(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setTitle(t, for: .noMoreData)
            }
        }
        base.labelLeftInset = inset
        base.stateLabel?.font = font;
        base.stateLabel?.textColor = color
        return self
    }
}
//MARK:--- MJRefreshAutoStateFooter 重设置 ----------
public extension Bee where Base: MJRefreshAutoStateFooter {
    /// 设置文字
    @discardableResult
    func setTitle(isHidden:Bool = true,
                  font:UIFont = UIFont.systemFont(ofSize: 14),
                  color:UIColor = UIColor.gray,
                  inset:CGFloat = 0,
                  title:[RefreshModel.TitlesEnum] = [.idle(""),
                                                          .pulling(""),
                                                          .refreshing(""),
                                                          .willRefresh(""),
                                                          .noMoreData("")]
        ) -> Bee
    {
        base.isRefreshingTitleHidden = isHidden
        base.stateLabel?.isHidden = isHidden
        guard !isHidden else {
            return self
        }
        for item in title {
            switch item {
            case .idle(let t):
                base.setTitle(t, for: .idle)
            case .pulling(let t):
                base.setTitle(t, for: .pulling)
            case .refreshing(let t):
                base.setTitle(t, for: .refreshing)
            case .willRefresh(let t):
                base.setTitle(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setTitle(t, for: .noMoreData)
            }
        }
        base.labelLeftInset = inset
        base.stateLabel?.font = font;
        base.stateLabel?.textColor = color
        return self
    }
}
//MARK:--- MJRefreshBackGifFooter 重设置 ----------
public extension Bee where Base: MJRefreshBackGifFooter {
    /// 设置时间
    @discardableResult
    func setImages(_ images:[RefreshModel.ImagesEnum] = [.idle([]),
                                                              .pulling([]),
                                                              .willRefresh([]),
                                                              .refreshing([]),
                                                              .noMoreData([])]
        ) -> Bee
    {
        for item in images {
            switch item {
            case .idle(let t):
                base.setImages(t, for: .idle)
            case .pulling(let t):
                base.setImages(t, for: .pulling)
            case .refreshing(let t):
                base.setImages(t, for: .refreshing)
            case .willRefresh(let t):
                base.setImages(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setImages(t, for: .noMoreData)
            }
        }
        return self
    }
}

//MARK:--- MJRefreshAutoGifFooter 重设置 ----------
public extension Bee where Base: MJRefreshAutoGifFooter {
    /// 设置时间
    @discardableResult
    func setImages(_ images:[RefreshModel.ImagesEnum] = [.idle([]),
                                                              .pulling([]),
                                                              .willRefresh([]),
                                                              .refreshing([]),
                                                              .noMoreData([])]
        ) -> Bee
    {
        for item in images {
            switch item {
            case .idle(let t):
                base.setImages(t, for: .idle)
            case .pulling(let t):
                base.setImages(t, for: .pulling)
            case .refreshing(let t):
                base.setImages(t, for: .refreshing)
            case .willRefresh(let t):
                base.setImages(t, for: .willRefresh)
            case .noMoreData(let t):
                base.setImages(t, for: .noMoreData)
            }
        }
        return self
    }
}
