# Vlickr

## Main features

Some major features of a video-sharing application.

* Users can upload videos
* Users can create folders or albums to store videos
* Users can add title and captions to videos
* Users can comment on videos
* videos have friendly URLs
* videos can be publicly viewable by all or privately by the user only
* Users can share videos with other users through the site
* Users can share videos with anonymous users

## Albums and videos

Vlickr uses a simple design to store and manage videos. An album is a
container of videos. Each album belongs to a single user and can be shared through
that user. Each album has a cover video, which is the representative video that is
when displaying albums.

## Uploading and storing videos

Uploading and storing videos properly is a critical part of any media-sharing
application. A good media-sharing application should have a user-friendly video
uploading interface and speedy file transfer rates. Uploading for Vlickr is simple 
and follows a conventional HTML file upload format, which is a very familiar interface 
to most users. There can be multiple ways of storing videos for Vlickr. The easiest and most
direct way is to store the videos locally in the same server that runs the application.
As you can imagine while this is relatively easy to implement it has many flaws.
The most obvious flaw is that the server will run out of disk space quickly if the
application data grows. Scaling becomes an issue at a later stage because it will be
difficult to run multiple servers easily to load balance. 

Another way of storing videos is up in the cloud where services such as the Ooyala offer 
video storage and administration facilities as well as Flash players to play videos. 
The advantages of using cloud storage are:

* Very scalable, can store very large amounts of data in the cloud
* Very little to no consideration for maintenance of servers or facilities
* Considerably cheaper than storing the data yourselves
* Can be used by multiple servers at the same time

## Comments

An important part of any Web 2.0 site is the community element of the site. Central
to building communities is providing a means for users to contribute back to the
site, in this case commenting on videos that are shared by users. The commenting
mechanism itself is quite simple. Each video can have one or more comments and
any user can create a comment. 

##Sharing videos

Sharing videos is a main purpose of any video-sharing application. When it comes to 
basic features, storing and sharing videos with friends are the key purposes of any 
video-sharing application and these two features are the highlight of Vlickr.

Sharing videos to non-users can be done through the user video embed codes above to 
any one via browser. That will share albums and videos that belong to a particular
user to anyone. Only public videos will be shown in those albums. Sharing videos to
users of the Vlickr can be done through Ooyala's provided players. If you follow another user,
you will see his/her videostream (the latest videos he/she uploaded). One of the main 
features in any social network involves modeling the interaction between its users. 
You can follow anyone that catches your fancy and the number of followers any one person 
can have can be very large. Vlickr uses a very simple mechanism for sharing videos. 
Instead of deliberately sharing with friends, the sharing mechanism is inversed. 
Your followers are able to view your videos through their portal whenever you upload new videos, 
without any directed effort on your part (sharing becomes very easy). Conversely, 
the more people you follow, the more videos you can view in your videostream. 
This encourages users to follow more users.
