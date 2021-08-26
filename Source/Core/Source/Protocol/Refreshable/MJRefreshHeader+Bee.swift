import Foundation
import UIKit

//MARK:--- MJRefreshNormalHeader 重设置 ----------
//MARK:--- MJRefreshAutoFooter 重设置 ----------
public extension Bee where Base: MJRefreshHeader {
    /// 忽略多少scrollView的contentInset的bottom
    @discardableResult
    func ignoredContentInsetTop(_ t:CGFloat = 0) -> Bee {
        base.ignoredScrollViewContentInsetTop = t
        return self
    }
}
public extension Bee where Base: MJRefreshNormalHeader {

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
public extension Bee where Base: MJRefreshStateHeader {
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
                                                          .noMoreData(""),]
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

    /// 设置时间
    @discardableResult
    func setTime(isHidden:Bool = true,
                 font:UIFont = UIFont.systemFont(ofSize: 12),
                 color:UIColor = UIColor.gray,
                 timeText:((Date)->(String))? = nil
        ) -> Bee
    {
        base.lastUpdatedTimeLabel?.isHidden = isHidden
        guard !isHidden else {
            return self
        }
        base.lastUpdatedTimeLabel?.font = font
        base.lastUpdatedTimeLabel?.textColor = color
        base.lastUpdatedTimeText = { (date) -> String in
            return timeText?(date ?? Date()) ?? ""
        }
        return self
    }
}


//MARK:--- MJRefreshGifHeader 重设置 ----------
public extension Bee where Base: MJRefreshGifHeader {

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
