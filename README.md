Navigation – Social Network Shell

Project Description

Navigation is an educational project that represents a social network shell developed for iOS using UIKit. It showcases modern approaches to building user interfaces and basic navigation within an app.

The project includes a user profile, a feed of posts, a favorites section, and other features that demonstrate flexibility in architecture and code structure.

Core Features
	1.	User Profile:
	•	Displays avatar, name, and user status.
	•	Metrics block (posts, subscriptions, followers).
	•	Action block with icons (Post, Story, Photo).
	•	Photo gallery with horizontal scrolling.
	2.	Feed of Posts:
	•	List of posts with content (text, image, view counter).
	•	Interactive features (post selection and view counter updates).
	3.	Favorites Section:
	•	Section for saved posts.
	4.	Navigation:
	•	Navigation between screens using UINavigationController and UITabBarController.
	•	Responsive interface for different devices.

Project Architecture

The project follows the MVC (Model-View-Controller) design pattern:
	•	Model: Data models for users, posts, and photos.
	•	View: User interface built using UIKit, including UITableView, UIStackView, and AutoLayout.
	•	Controller: UIViewController manages UI logic and user interactions.

Project Structure
	•	Navigation
	•	Profile/
	•	ProfileViewController.swift – User profile screen
	•	ProfileHeaderView.swift – Custom table header view
	•	PhotosTableViewCell.swift – Table cell for the photo gallery
	•	PostTableViewCell.swift – Table cell for posts
	•	Feed/
	•	FeedViewController.swift – Feed screen
	•	PostModel.swift – Post data model
	•	Favorites/
	•	FavoritesViewController.swift – Favorites section screen
	•	AppDelegate.swift – App configuration
	•	SceneDelegate.swift – Scene setup and navigation
	•	Assets.xcassets – App assets (icons, images)
Interface Screenshots

Profile Screen:

Posts Feed:

Favorites Section:

Technologies & Tools
	•	Swift: Programming language.
	•	UIKit: UI framework for building the interface.
	•	AutoLayout: Flexible UI constraints.
	•	UINavigationController & UITabBarController: App navigation.
	•	Xcode: Development environment.

How to Run the Project
	1.	Clone the repository:
git clone https://github.com/your-repo/Navigation.git
	2.	Open the project in Xcode.
	3.	Select a simulator or connect a physical device.
	4.	Run the project:

Cmd + R


Contact
	•	Email: msergey95@gmail.com
