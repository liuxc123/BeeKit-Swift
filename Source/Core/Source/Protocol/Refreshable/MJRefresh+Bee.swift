import Foundation
import UIKit

//MARK:--- MJRefresh 添加 ----------
public extension Bee where Base: UIScrollView {

    //MARK:--- 下拉 ----------
    /// 添加默认下拉 - 添加自定义模型 block 回调 custom 自定义
    @discardableResult
    func headerNormalWithModel(_ block: @escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshNormalHeader?)->Void)? = nil) -> Bee {
        let mj = MJRefreshNormalHeader(refreshingBlock: block)
        self.header(normal:mj, model: model)
        custom?(mj)
        base.mj_header = mj
        return self
    }

    /// 添加默认下拉 - 不添加自定义模型，使用默认，不加载MJRefresh单例
    @discardableResult
    func headerNormal(_ block: @escaping MJRefreshComponentAction, custom: ((MJRefreshNormalHeader?)->Void)? = nil) -> Bee {
        let mj = MJRefreshNormalHeader(refreshingBlock: block)
        self.header(normal:mj, model: nil)
        custom?(mj)
        base.mj_header = mj
        return self
    }

    /// 添加Gif下拉
    @discardableResult
    func headerGifWithModel( _ block:@escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshGifHeader?)->Void)? = nil) -> Bee {
        let mj = MJRefreshGifHeader(refreshingBlock: block)
        self.headerGif(mj, model: model)
        custom?(mj)
        base.mj_header = mj
        return self
    }

    /// 添加Gif下拉 - 不添加自定义模型，使用默认，不加载MJRefresh单例
    @discardableResult
    func headerGif( _ block:@escaping MJRefreshComponentAction, custom:((MJRefreshGifHeader?)->Void)? = nil) -> Bee {
        let mj = MJRefreshGifHeader(refreshingBlock: block)
        self.headerGif(mj, model: nil)
        custom?(mj)
        base.mj_header = mj
        return self
    }

    private func header(normal mj: MJRefreshNormalHeader?, model:RefreshModel?) {
        guard let m = model  else {
            mj?.bee.activityStyle().setTitle().setTime()
            return
        }
        mj?.bee
            .activityStyle(m.down_activityStyle)
            .ignoredContentInsetTop(m.ignoredContentInsetTop)
        self.header(mj, m: m)
    }

    private func header(_ mj: MJRefreshStateHeader?, m:RefreshModel) {
        mj?.bee
            .setTitle(isHidden: m.down_txtHidden,
                      font: m.down_txtFont,
                      color: m.down_txtColor,
                      inset: m.down_leftInset,
                      title: [.idle(m.down_txtIdle),
                              .pulling(m.down_txtPulling),
                              .willRefresh(m.down_txtWillRefresh),
                              .refreshing(m.down_txtRefreshing),
                              .noMoreData(m.down_txtNoMoreData)])
            .setTime(isHidden: m.down_timeHidden,
                     font: m.down_timeFont,
                     color: m.down_timeColor,
                     timeText: { (date) -> (String) in
                        return m.down_timeText?(date) ?? ""
            })
    }

    private func headerGif(_ mj: MJRefreshGifHeader?, model:RefreshModel?) {
        guard let m = model  else {
            mj?.bee.setTitle().setTime().setImages()
            return
        }
        self.header(mj, m: m)
        mj?.bee.setImages([.idle(m.down_imgIdle),
                          .pulling(m.down_imgPulling),
                          .willRefresh(m.down_imgWillRefresh),
                          .refreshing(m.down_imgRefreshing),
                          .noMoreData(m.down_imgNoMoreData)])
    }

    //MARK:--- 上拉 ----------

    /// 添加默认上拉
    @discardableResult
    func footerNormalBack( _ block:@escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshBackNormalFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshBackNormalFooter(refreshingBlock: block)
        self.footer(withBack: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }

    /// 添加默认上拉
    @discardableResult
    func footerNormalBackWithModel( _ block:@escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshBackNormalFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshBackNormalFooter(refreshingBlock: block)
        self.footer(withBack: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加默认上拉 - 自动刷
    @discardableResult
    func footerAuto( _ block:@escaping MJRefreshComponentAction, custom:((MJRefreshAutoNormalFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshAutoNormalFooter(refreshingBlock: block)
        self.footer(withAuto: mj, model: nil)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加默认上拉 - 自动刷
    @discardableResult
    func footerAutoWithModel(_ block:@escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshAutoNormalFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshAutoNormalFooter(refreshingBlock: block)
        self.footer(withAuto: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉
    @discardableResult
    func footerGifBackWithModel( _ block:@escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshBackGifFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshBackGifFooter(refreshingBlock: block)
        self.footerGif(withBack: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉
    @discardableResult
    func footerMJGifBack( _ block:@escaping MJRefreshComponentAction, custom:((MJRefreshBackGifFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshBackGifFooter(refreshingBlock: block)
        self.footerGif(withBack: mj, model: nil)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉 - 自动刷
    @discardableResult
    func footerMJGifAutoWithModel( _ block:@escaping MJRefreshComponentAction, model:RefreshModel = Refresh.shared.model, custom:((MJRefreshAutoGifFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshAutoGifFooter(refreshingBlock: block)
        self.footerGif(withAuto: mj, model: model)
        custom?(mj)
        base.mj_footer = mj
        return self
    }
    /// 添加Gif上拉 - 自动刷
    @discardableResult
    func footerMJGifAuto( _ block:@escaping MJRefreshComponentAction, custom:((MJRefreshAutoGifFooter?)->Void)? = nil) -> Bee {
        let mj = MJRefreshAutoGifFooter(refreshingBlock: block)
        self.footerGif(withAuto: mj, model: nil)
        custom?(mj)
        base.mj_footer = mj
        return self
    }

    private func footer(withBack mj: MJRefreshBackNormalFooter?, model:RefreshModel?) {
        guard let m = model else {
            mj?.bee.activityStyle().setTitle()
            return
        }
        mj?.bee
            .activityStyle(m.up_activityStyle)
        self.footer(back: mj, model: m)
    }
    private func footer(withAuto mj: MJRefreshAutoNormalFooter?, model:RefreshModel?) {
        guard let m = model else {
            mj?.bee
                .activityStyle()
                .setTitle()

            return
        }
        mj?.bee.activityStyle(m.up_activityStyle)
        self.footer(auto: mj, model: m)
    }

    private func footer(back mj: MJRefreshBackStateFooter?, model:RefreshModel) {
        mj?.bee.setTitle(isHidden: model.up_txtHidden,
                        font: model.up_txtFont,
                        color: model.up_txtColor,
                        inset: model.up_leftInset,
                        title: [.idle(model.up_txtIdle),
                                .pulling(model.up_txtPulling),
                                .willRefresh(model.up_txtWillRefresh),
                                .refreshing(model.up_txtRefreshing),
                                .noMoreData(model.up_txtNoMoreData)])
    }
    private func footer(auto mj: MJRefreshAutoStateFooter?, model:RefreshModel) {
        mj?.bee
            .setTitle(isHidden: model.up_txtHidden,
                        font: model.up_txtFont,
                        color: model.up_txtColor,
                        inset: model.up_leftInset,
                        title: [.idle(model.up_txtIdle),
                                .pulling(model.up_txtPulling),
                                .willRefresh(model.up_txtWillRefresh),
                                .refreshing(model.up_txtRefreshing),
                                .noMoreData(model.up_txtNoMoreData)])
            .isAutoRefresh(model.isAutoRefresh)
            .autoRefreshPercent(model.autoRefreshPercent)
            .ignoredContentInsetBottom(model.ignoredContentInsetBottom)

    }
    private func footerGif(withBack mj: MJRefreshBackGifFooter?, model:RefreshModel?) {
        guard let m = model else {
            mj?.bee.setTitle().setImages()
            return
        }
        self.footer(back: mj, model: m)
        mj?.bee
            .setImages([.idle(m.up_imgIdle),
                        .pulling(m.up_imgPulling),
                        .willRefresh(m.up_imgWillRefresh),
                        .refreshing(m.up_imgRefreshing),
                        .noMoreData(m.up_imgNoMoreData)])

    }
    private func footerGif(withAuto mj: MJRefreshAutoGifFooter?, model:RefreshModel?) {
        guard let m = model else {
            mj?.bee.setTitle().setImages()
            return
        }
        self.footer(auto: mj, model: m)
        mj?.bee
            .setImages([.idle(m.up_imgIdle),
                        .pulling(m.up_imgPulling),
                        .willRefresh(m.up_imgWillRefresh),
                        .refreshing(m.up_imgRefreshing),
                        .noMoreData(m.up_imgNoMoreData)])
    }

    /// 设置刷新状态
    @discardableResult
    func refreshStatus(_ status:[RefreshModel.RefreshStatus]) -> Bee {
        var status = status
        status.sort{$0.intValue < $1.intValue}
        for item in status {
            switch item {
            case .beginRefresh:
                self.beginRefreshing()
            case .endRefresh(let n):
                self.endRefreshing(n)
            case .noMoreDataEnd:
                self.endRefreshingWithNoMoreData()
            case .noMoreDataReset:
                self.resetNoMoreData()
            case .hiddenFoot(let h):
                self.hiddenFoot(h)
            }
        }
        return self
    }

    /// 开始刷新
    @discardableResult
    func beginRefreshing() -> Bee {
        if let header = base.mj_header, !header.isRefreshing {
            base.mj_footer?.endRefreshing()
            base.mj_header?.beginRefreshing()
        }
        return self
    }

    /// 结束刷新
    @discardableResult
    func endRefreshing() -> Bee {
        base.mj_header?.endRefreshing()
        base.mj_footer?.endRefreshing()
        return self
    }

    /// 结束刷新-是否无数据
    @discardableResult
    func endRefreshing(_ noMoreData: Bool = false) -> Bee {
        base.mj_header?.endRefreshing()
        base.mj_footer?.endRefreshing()
        if noMoreData { base.mj_footer?.endRefreshingWithNoMoreData() }
        return self
    }

    /// 结束刷新-无数据
    @discardableResult
    func endRefreshingWithNoMoreData() -> Bee {
        base.mj_header?.endRefreshing()
        base.mj_footer?.endRefreshingWithNoMoreData()
        return self
    }

    /// 重置底部刷新
    @discardableResult
    func resetNoMoreData() -> Bee {
        base.mj_footer?.resetNoMoreData()
        return self
    }

    /// 隐藏底部刷新
    @discardableResult
    func hiddenFoot(_ b:Bool) -> Bee {
        base.mj_footer?.isHidden = b
        return self
    }
}
