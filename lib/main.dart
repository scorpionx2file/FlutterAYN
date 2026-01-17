import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/constants/report/report_bottom_sheet.dart';
import 'package:traveller/core/constants/service_provider/service_provider.dart';
import 'package:traveller/core/constants/service_provider/service_provider_bottom.dart';
import 'package:traveller/core/constants/warning/warning.dart';
import 'package:traveller/core/theme/theme_data/theme_data_light.dart';
import 'package:traveller/event_option/presentation/widgets/content_section/content_section.dart';
import 'package:traveller/map/presenttion/widgets/map_screen.dart';
import 'package:traveller/settings_contact/presentation/widgets/contact_message_textarea.dart';
import 'package:traveller/stories/presentation/widgets/story_screen.dart';
import 'config/routes/router.dart';
import 'core/constants/activity_card/activity_card.dart';
import 'core/constants/comment/comment_item.dart';
import 'core/constants/comment/rating_widget.dart';
import 'core/constants/event_options/event_options_activities/event_options_activities.dart';
import 'core/constants/event_options/event_options_posts/event_options_posts.dart';
import 'core/constants/followers_list/followers_list_tile.dart';
import 'core/constants/post/post.dart';
import 'core/constants/post/post_content/post_content.dart';
import 'core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import 'core/constants/story_item/story_item.dart';
import 'core/theme/colors/app_colors.dart';
import 'core/utils/map_bottom_sheet_util.dart';
import 'core/utils/post_utils.dart';
import 'core/constants/user_profile/user_profile_header.dart';
import 'event_option/presentation/widgets/place_details_screen.dart';
import 'home/presentation/widgets/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: getLightTheme(), // ✅ ScreenUtil ready
          );
        },
      ),
    );
  }
}






class HomeRoot extends StatelessWidget {
  const HomeRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final headerData1 = PostHeaderData(
      postId: '1',
      imageUrl:
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
      username: 'Sarah Ahmed',
      jobOrLocation: 'UI Designer',
      rate: 4.8,
      description:
      'This is a sample post description to test expandable text behavior in the feed.',
      isHighlighted: false,
    );

    final headerData2 = PostHeaderData(
      postId: '2',
      imageUrl:
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
      username: 'Sarah Ahmed',
      jobOrLocation: 'UI Designer',
      rate: 4.8,
      description:
      'This is a sample post description to test expandable text behavior in the feed.',
      isHighlighted: false,
    );

    final headerData3 = PostHeaderData(
      postId: '3',
      imageUrl:
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
      username: 'Sarah Ahmed',
      jobOrLocation: 'UI Designer',
      rate: 4.8,
      description:
      'This is a sample post description to test expandable text behavior in the feed.',
      isHighlighted: false,
    );

    final headerData4 = PostHeaderData(
      postId: '4',
      imageUrl:
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
      username: 'Sarah Ahmed',
      jobOrLocation: 'UI Designer',
      rate: 4.8,
      description:
      'This is a sample post description to test expandable text behavior in the feed.',
      isHighlighted: false,
    );

    final headerData5 = PostHeaderData(
      postId: '5',
      imageUrl:
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
      username: 'Sarah Ahmed',
      jobOrLocation: 'UI Designer',
      rate: 4.8,
      description:
      'This is a sample post description to test expandable text behavior in the feed.',
      isHighlighted: false,
    );

        final contentData = PostContentData(
          mediaUrls: [
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            'https://picsum.photos/800/400',
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          ],
          commenterAvatars: [
            'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
            'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
          ],
          commentsCountText: '12',
        );

        final contentData1 = PostContentData(
          mediaUrls: [
            'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
            'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
          ],
          commenterAvatars: [
            'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
            'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
          ],
          commentsCountText: '12',
        );

        final contentData2 = PostContentData(
          mediaUrls: [
          ],
          commenterAvatars: [
            'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
            'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
          ],
          commentsCountText: '12',
        );

        final contentData3 = PostContentData(
          mediaUrls: [
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4",
            "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_5mb.mp4"
          ],
          commenterAvatars: [],
          commentsCountText: '12',
        );

        final stories = [
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false,
              data: "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg"
          ),
          Story(
            imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
            username: "Habiba",
            isSeen: true,
            data: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4"
          ),
          Story(
            imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
            username: "Habiba",
            isSeen: true,
            data: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg"
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: true,
            data: "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg"
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false,
            data: "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg"
          ),
          Story(
              imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
              username: "Habiba",
              isSeen: false,
            data: "https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg"
          ),
        ];

        final activities = [
          Activity(
            imageUrl: 'https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg',
            title: 'FIFA World Cup',
            category: 'Sports',
            time: 'Nov 23, 12PM',
          ),
          Activity(
            imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
            title: 'Morning Run',
            category: 'Running',
            time: 'Dec 2, 7AM',
          ),
        ];

         posts = [
          PostData(
            headerData: headerData1,
            contentData: contentData,
          ),
          PostData(
            headerData: headerData2,
            contentData: contentData1,
          ),
          PostData(
            headerData: headerData3,
            contentData: contentData2,
          ),
          PostData(
            headerData: headerData4,
            contentData: contentData3,
          ),
          PostData(
            headerData: headerData5,
            contentData: contentData,
          ),
        ];

        final placeCont = PlaceContent(
            maxTemp: 25,
            minTemp: 15,
            numOfPosts: 200,
            gateTitle: "Tourism to Egypt",
            gateDesc: "It is a long-established fact that the readable content of a page will distract the reader from focusing.",
            friendsImages: [
              'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
              'https://images.pexels.com/photos/1133957/pexels-photo-1133957.jpeg',
            'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg',
             ],
            numOfFriends: 200
        );
        final placeInfo = PlaceInfoModel(
          gateName: "Egypt Gate",
          placeContent: placeCont
        );

        final eventPosts = [
          EventPostsData(
            imageUrl: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            username: "Habiba",
            title: "Morning Run",
            date: "Dec 2, 7AM",
            postImage: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            rate: 4.8,
          ),EventPostsData(
            imageUrl: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            username: "Habiba",
            title: "Morning Run",
            date: "Dec 2, 7AM",
            postImage: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            rate: 4.8,
          ),EventPostsData(
            imageUrl: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            username: "Habiba",
            title: "Morning Run",
            date: "Dec 2, 7AM",
            postImage: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            rate: 4.8,
          ),
          EventPostsData(
            imageUrl: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            username: "Habiba",
            title: "Morning Run",
            date: "Dec 2, 7AM",
            postImage: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
            rate: 4.8,
          )
        ];


    final List<CommentData> postComments = [
      CommentData(
        'https://i.pravatar.cc/150?img=1',
        'Ahmed',
        '2h',
        const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
        'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
        false,
      ),
      CommentData(
          'https://i.pravatar.cc/150?img=2',
          'Sara',
          '1h',
          const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
          'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
          false
      ),
      CommentData(
          'https://i.pravatar.cc/150?img=3',
          'Omar',
          '10m',
          const Icon(Icons.shopping_bag_rounded, color: AppColors.spanishGrey, size: 18),
          'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
          false
      ),
    ];

    final List<CommentData> serviceProviderComments = [
      CommentData(
        'https://i.pravatar.cc/150?img=1',
        'Ahmed',
        '2h',
        RatingWidget(rating: 4.8),
        'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
        true,
      ),
      CommentData(
          'https://i.pravatar.cc/150?img=2',
          'Sara',
          '1h',
          RatingWidget(rating: 4.8),
          'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
          true
      ),
      CommentData(
          'https://i.pravatar.cc/150?img=3',
          'Omar',
          '10m',
          RatingWidget(rating: 2.2),
          'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
          true
      ),
      CommentData(
          'https://i.pravatar.cc/150?img=3',
          'Omar',
          '10m',
          RatingWidget(rating: 2.2),
          'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
          true
      ),
      CommentData(
          'https://i.pravatar.cc/150?img=3',
          'Omar',
          '10m',
          RatingWidget(rating: 2.2),
          'A wonderful experience, Karim! I hope you can repeat the trip or organize a similar one to the beautiful Egyptian desert. Thank you so much!',
          true
      ),
    ];

    final List<MapItem> items = [
      /// 🟢 POST
      MapItem(
        location: LatLng(52.5200, 13.4050),
        type: MarkerType.post,
        imageUrl: posts[0].headerData.imageUrl,
        postData: posts[0].headerData,
        postContentData: posts[0].contentData,
        comments: postComments,
      ),

      /// 🔵 SERVICE PROVIDER
      MapItem(
        location: LatLng(48.8566, 2.3522),
        type: MarkerType.service,
        imageUrl: headerData1.imageUrl,
        serviceHeaderData: headerData1,
        locationText: "Paris, France",
        language: "English / French",
        comments: serviceProviderComments,
      ),

      MapItem(
        location: LatLng(50.1109, 8.6821),
        type: MarkerType.post,
        imageUrl: posts[1].headerData.imageUrl,
        postData: posts[1].headerData,
        postContentData: posts[1].contentData,
        comments: postComments,
      ),

      MapItem(
        location: LatLng(41.9028, 12.4964),
        type: MarkerType.service,
        imageUrl: headerData2.imageUrl,
        serviceHeaderData: headerData2,
        locationText: "Rome, Italy",
        language: "Italian / English",
        comments: serviceProviderComments,
      ),
    ];


    return Scaffold(
                body: SafeArea(
                  child:
                  MapScreen(
                    items: items,
                    onMarkerTab: (item) {
                      openMapItemBottomSheet(context, item);
                    },
                  ),
                  /*PlaceDetailsScreen(
                    placeInfo: placeInfo,
                    posts: eventPosts
                  )*/
                  /*ServiceProvider(
                      data: headerData,
                      location: "Cairo, Egypt",
                      language: "English")*/
                 /* HomeScreen(
                    stories: stories,
                    postData: posts,
                    activities: activities
                  )*/
                  /*EventOptionsPosts(
                    data: EventPostsData(
                      imageUrl: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
                      username: "Habiba",
                      title: "Morning Run",
                      date: "Dec 2, 7AM",
                      postImage: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
                      rate: 4.8,
                    )
                  )*/
                  /*EventOptionsActivities(
                    data: EventActivitiesData(
                      imageUrl: "https://images.pexels.com/photos/11829358/pexels-photo-11829358.jpeg",
                      title: "Morning Run",
                      date: "Dec 2, 7AM",
                      category: "Running",
                    ),
                  )*/

                  /*UserProfileHeader(
                    isMyProfile: false,
                    isVerified: true,
                    coverImage: const AssetImage(
                        'assets/images/profileCover.png'),
                    profileImage: const AssetImage('assets/images/profile.png'),
                    username: 'محمود السعدي',
                    jobTitle: 'مقدم خدمة',
                    bio:
                    'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيُلهي القارئ',
                    location: 'الغردقة، مصر',
                    firstNumber: 1689,
                    secondNumber: 31700,
                    thirdNumber: 735,
                    onTwitterTap: () {},
                    onSnapchatTap: () {},
                  )*/
                  /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Warning(
                      warningTitle: "Warning",
                      warningContent: "This is a sample warning message.",
                    ),
                  )*/
                  /*StoryScreen(stories: stories),
                  )*/
                )
    );
  }
}

/// UserProfileHeader
// UserProfileHeader(
// isMyProfile: false,
// isVerified: true,
// coverImage: const AssetImage(
// 'assets/images/profileCover.png'),
// profileImage: const AssetImage('assets/images/profile.png'),
// username: 'محمود السعدي',
// jobTitle: 'مقدم خدمة',
// bio:
// 'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيُلهي القارئ',
// location: 'الغردقة، مصر',
// firstNumber: 1689,
// secondNumber: 31700,
// thirdNumber: 735,
// onTwitterTap: () {},
// onSnapchatTap: () {},
// ),

/// FollowersListTile
// FollowersListTile(
// story: Story(
// imageUrl: 'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg',
// isSeen: false
// ),
// name: 'Adham Mohamed',
// points: 535,
// buttonText: 'Follow',
// isFollowing: false,
// onButtonPressed: () {},
// onStoryTap: () {},
// )

/// ContactMessageTextArea
//ContactMessageTextArea(),
