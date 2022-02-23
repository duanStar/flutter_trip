import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_item.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/webview.dart';

const PAGE_SIZE = 10;

class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;

  const TravelTabPage({Key? key, required this.groupChannelCode})
      : super(key: key);

  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> _items = [];
  late TravelModel _travelModel;
  int pageIndex = 0;
  bool isLoading = true;
  ScrollController scrollController = ScrollController();

  loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelModel travelModel = await TravelDao.fetchTabDetail(
          groupChannelCode: widget.groupChannelCode,
          pageIndex: pageIndex,
          pageSize: PAGE_SIZE);
      setState(() {
        _travelModel = travelModel;
        if (_items.isNotEmpty) {
          _items.addAll(_filterItems(travelModel.travelItems));
        } else {
          _items = _filterItems(travelModel.travelItems);
        }
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
          child: RefreshIndicator(
            child: MediaQuery.removePadding(
              context: context,
              child: MasonryGridView.count(
                controller: scrollController,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _TravelItem(
                    index: index,
                    travelItem: _items[index],
                  );
                },
              ),
              removeTop: true,
            ),
            onRefresh: _onRefresh,
          ),
          isLoading: isLoading),
    );
  }

  _filterItems(List<TravelItem> lists) {
    if (lists == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    lists.forEach((item) {
      if (item.article != null) {
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() {
    setState(() {
      pageIndex = 1;
    });
    return loadData();
  }
}

class _TravelItem extends StatelessWidget {
  final int index;
  final TravelItem travelItem;

  const _TravelItem({required this.index, required this.travelItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (travelItem.article.urls != null &&
            travelItem.article.urls.length > 0) {
          NavigatorUtil.push(
              context,
              WebView(
                  url: travelItem.article.urls[0].h5Url,
                  title: "详情",
                  hideAppBar: false));
        }
      },
      child: Card(
        child: PhysicalModel(
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  travelItem.article.articleTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: [
        Image.network(travelItem.article.images[0].dynamicUrl),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
                color: Colors.black54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _poiName() {
    return travelItem.article.pois[0].poiName == null
        ? "未知"
        : travelItem.article.pois[0].poiName;
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    travelItem.article.author.coverImage.dynamicUrl,
                    width: 24,
                    height: 24,
                  )),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  travelItem.article.author.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  travelItem.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
