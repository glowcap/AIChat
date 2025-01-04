# AI Chat 💬 
AIChat allows users to generate AI avatars to chat with.

## Branching
Branches are broken into sections and parts. Naming follows sXXpXX (ie. Section 01 Part: 01). Use the following to reference specific branches 

### Module 1: Project Setup 

1. Project Settings, Github, App Icon, & Launch Screen
2. Adding SwiftLint
3. Routing between Signed In vs Signed Out
4. Setup TabBar and NavigationStacks
5. Adding root App State to the Environment

### Module 2: Onboarding Flow

1. WelcomeView & ImageLoaderView
2. OnboardingIntroView & OnboardingColorView
3. OnboardingCompletedView

### Module 3: TabBar Flow

1. ExploreView: HeroCellView
2. AvatarModel
3. ExploreView: CarouselView
4. ExploreView: CategoryCell
5. ExploreView: CustomListCellView
6. ChatModel
7. ChatsView: ChatRowCellView
8. UserModel & ProfileView
9. CreateAccountView & SettingsView

### Module 4: Feature Flow

 1. CreateAvatarView
 2. ChatView: ChatBubbleView
 3. ChatView: ScrollView
 4. AnyAppAlert: Custom Alerts
 5. ModalSupportView: Custom Modals

## Things to do

- [ ] iOS 18+ branch
- [ ] replace SDWebImageSwiftUI with native solution
- [ ] accessibility
- [ ] localize Strings
- [ ] assign Constants
- [ ] CarouselView support for viewAligned non-centered items
- [ ] inline docs
- [ ] clean up ViewModifiers.swift
- [ ] implement profanity filter
- [ ] ModalSupportView background color dark mode support
