

import 'package:flutter/material.dart';
import 'package:q_trip_user/core/extensions/num_extensions.dart';
import 'package:q_trip_user/presentation/component/component.dart';

import '../../domain/logger.dart';

class PaginationListView<T> extends StatefulWidget {
  final VoidCallback _onLoadMore;

  final bool _isLoading;

  final List<T> _list;
  final int _currentPage;
  final int _totalPages;
 final NullableIndexedWidgetBuilder _builder;

  @override
  _PaginationListViewState createState() => _PaginationListViewState();

  const  PaginationListView({Key? key,
    required VoidCallback onLoadMore,
    required bool isLoading,
    required List<T> list,
    required int currentPage,
    required int totalPages,
    required NullableIndexedWidgetBuilder builder,
  })  : _onLoadMore = onLoadMore,
        _isLoading = isLoading,
        _list = list,
        _currentPage = currentPage,
        _totalPages = totalPages,
        _builder = builder, super(key: key);
}

class _PaginationListViewState extends State<PaginationListView> {
  final ScrollController _scrollController =  ScrollController();


  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(() {});
  }

  @override
  void initState() {
    super.initState();

    if (widget._currentPage >= widget._totalPages) {
      _scrollController.removeListener(() {});
    }


    _scrollController.addListener(() {
      // Listening while at the bottom of the page
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange &&
          widget._currentPage < widget._totalPages
      ) {
        log('PaginationListView', '_currentPage:${widget._currentPage} _totalPages:${widget._totalPages} ${ widget._currentPage <= widget._totalPages}');
        widget._onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [

        SliverList(
          delegate: SliverChildBuilderDelegate(widget._builder,
            childCount: widget._list.length,

          ),

        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 40.h,
            child: Center(
              child: widget._isLoading
                  ? const CustomLoadingSpinner()
                  :  SizedBox(height: 40.0.h),
            ),
          ),
        ),
      ],
    );
  }
}



class CustomPaginationListView<T> extends StatefulWidget {
  final Function _onLoadMore;

  final bool _isLoading;
  final bool _isMoreLoading;
  final List<Widget>? _slivers;
  final int _itemCount;
  final int _currentPage;
  final bool _hasMorePages;
  final NullableIndexedWidgetBuilder _builder;

  @override
  _CustomPaginationListViewState createState() => _CustomPaginationListViewState();

  const CustomPaginationListView({Key? key,
    required VoidCallback onLoadMore,
    required bool isMoreLoading,
    bool isLoading=false,
    List<Widget>? slivers,
    required int itemCount,
    required int currentPage,
    required bool hasMorePages,
    required NullableIndexedWidgetBuilder builder,
  })  : _onLoadMore = onLoadMore,
        _isMoreLoading = isMoreLoading,
        _isLoading = isLoading,
        _slivers = slivers,
        _itemCount = itemCount,
        _currentPage = currentPage,
        _hasMorePages = hasMorePages,
        _builder = builder, super(key: key);
}

class _CustomPaginationListViewState extends State<CustomPaginationListView> {
  final ScrollController _scrollController =  ScrollController();

  bool _canLoadMore = true;
  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(() {});
  }

  @override
  void initState() {
    super.initState();

    if (!widget._hasMorePages) {
      _scrollController.removeListener(() {});
    }

    _scrollController.addListener(() async{
      // Listening while at the bottom of the page
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent-200 && !widget._isLoading &&
          /*!_scrollController.position.outOfRange &&*/ widget._hasMorePages&&_canLoadMore) {
        setState(() {_canLoadMore = false;});
        await widget._onLoadMore();
        setState(() {_canLoadMore = true;});

      }
    });
    // _scrollController.addListener(() {
    //   // Listening while at the bottom of the page
    //   if (_scrollController.position.pixels >= (_scrollController.position.maxScrollExtent-150.h) &&! widget._isLoading&&
    //   // if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
    //       !_scrollController.position.outOfRange && widget._currentPage <= widget._hasMorePages
    //   ) {
    //     widget._onLoadMore();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,

      slivers: [
        if (widget._slivers != null)...widget._slivers!,

        if(widget._isLoading)...[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            leadingWidth: 0,
            elevation: 0.0,
            leading: const SizedBox(),
            expandedHeight: 100.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace:  const CustomLoadingSpinner(),
          ),

        ]else if(widget._itemCount==0)...[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            leadingWidth: 0,
            elevation: 0.0,
            leading: const SizedBox(),
            expandedHeight: 300.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace:  const NoDataScreen(),
          ),
        ]else...[
          SliverList(delegate: SliverChildBuilderDelegate(widget._builder, childCount: widget._itemCount),),
        ],


        SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: Center(
              child: !widget._isLoading &&widget._isMoreLoading
                  ?  const CustomLoadingSpinner(size: 20,)
                  :  const SizedBox(height: 40.0),
            ),
          ),
        ),
      ],
    );
  }
}

