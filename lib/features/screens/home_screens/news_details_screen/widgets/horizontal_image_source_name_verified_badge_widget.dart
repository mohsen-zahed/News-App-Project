import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/constants/global_colors.dart';
import 'package:news_app/config/constants/images_paths.dart';
import 'package:news_app/features/bloc/news_details_bloc/bloc/bookmark_button_bloc.dart';
import 'package:news_app/packages/firebase_auth_package/firebase_auth_constants.dart';
import 'package:news_app/utils/my_media_query.dart';

class HorizontalImageSourceNameVerifiedBadgeWidget extends StatefulWidget {
  const HorizontalImageSourceNameVerifiedBadgeWidget({
    super.key,
    required this.generalNewsModel,
    required this.savedNewsList,
  });

  final List<dynamic> savedNewsList;
  final dynamic generalNewsModel;

  @override
  State<HorizontalImageSourceNameVerifiedBadgeWidget> createState() => _HorizontalImageSourceNameVerifiedBadgeWidgetState();
}

class _HorizontalImageSourceNameVerifiedBadgeWidgetState extends State<HorizontalImageSourceNameVerifiedBadgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //* News source tv icon...
        Container(
          width: getScreenArea(context, 0.00015),
          height: getScreenArea(context, 0.00015),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            image: DecorationImage(
              image: CachedNetworkImageProvider(cnnIconTvPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: getScreenArea(context, 0.00003),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    //* News source name...
                    child: Text(
                      '${widget.generalNewsModel.source}',
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 5),
                  //* Source verified badge...
                  Image.asset(
                    verifiedIconPath,
                    width: getScreenArea(context, 0.00005),
                    height: getScreenArea(context, 0.00005),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              //* News author text...
              Text(
                'By ${widget.generalNewsModel.author}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kGreyColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        BlocBuilder<BookmarkButtonBloc, BookmarkButtonState>(
          builder: (context, state) {
            bool isSaved = widget.savedNewsList.any((element) => element['title'] == widget.generalNewsModel.title);
            if (state is BookmarkButtonInitial) {
              return GestureDetector(
                onTap: () {
                  !isSaved
                      ? BlocProvider.of<BookmarkButtonBloc>(context).add(
                          BookmarkButtonIsClicked(
                            newsId: widget.generalNewsModel,
                            userId: globalUserId,
                          ),
                        )
                      : BlocProvider.of<BookmarkButtonBloc>(context).add(
                          RemoveBookmarkButtonIsClicked(
                            userId: globalUserId,
                            newsId: widget.generalNewsModel,
                          ),
                        );
                },
                child: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
                  size: getScreenArea(context, 0.000085),
                ),
              );
            } else if (state is BookmarkButtonSuccess) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<BookmarkButtonBloc>(context).add(
                    RemoveBookmarkButtonIsClicked(
                      newsId: widget.generalNewsModel,
                      userId: globalUserId,
                    ),
                  );
                },
                child: Icon(
                  Icons.bookmark,
                  size: getScreenArea(context, 0.000085),
                ),
              );
            } else if (state is RemoveBookmarkButtonSuccess) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<BookmarkButtonBloc>(context).add(
                    RemoveBookmarkButtonIsClicked(
                      newsId: widget.generalNewsModel,
                      userId: globalUserId,
                    ),
                  );
                },
                child: Icon(
                  Icons.bookmark_border_rounded,
                  size: getScreenArea(context, 0.000085),
                ),
              );
            } else if (state is BookmarkButtonFailed) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<BookmarkButtonBloc>(context).add(
                    BookmarkButtonIsClicked(
                      newsId: widget.generalNewsModel,
                      userId: globalUserId,
                    ),
                  );
                },
                child: Icon(
                  Icons.bookmark,
                  size: getScreenArea(context, 0.000085),
                ),
              );
            } else if (state is RemoveBookmarkButtonFailed) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<BookmarkButtonBloc>(context).add(
                    BookmarkButtonIsClicked(
                      newsId: widget.generalNewsModel,
                      userId: globalUserId,
                    ),
                  );
                },
                child: Icon(
                  Icons.bookmark_outline_rounded,
                  size: getScreenArea(context, 0.000085),
                ),
              );
            } else {
              throw 'state not supported';
            }
          },
        ),
      ],
    );
  }
}
