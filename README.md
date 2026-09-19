

# BUILD NACHOONRENT — PHASE 1

You are an expert product designer, UX architect, UI designer, and full-stack mobile application developer.

Build a production-quality mobile application called **Nachoonrent**.

Nachoonrent is a modern marketplace and community platform built around **Indian weddings, Baraat dancing, dancers, wedding organizers, and authentic Indian cultural experiences**.

The product must be designed as a scalable foundation for future international wedding tourism, but **Phase 1 must focus on the Indian wedding ecosystem**.

Do not build Phase 2 tourism infrastructure yet. However, the architecture and design must allow it to be added later without rebuilding the core application.

---

# 1. CORE PRODUCT IDEA

Nachoonrent connects people involved in Indian wedding celebrations.

The three main ecosystem components are:

### A. DANCERS

Professional or independent dancers can create public dancer profiles and become discoverable by wedding organizers.

Organizers can:

* Discover dancers
* Search/filter dancers
* Watch performance videos
* View photos
* View social media links
* Check availability
* View ratings/reviews
* View pricing
* Send booking requests

Dancers can:

* Create their own dancer profile
* Upload photos
* Upload/link dance videos
* Add social media
* Specify dance styles
* Set pricing
* Set availability
* Receive booking requests
* Accept/reject requests
* Manage upcoming bookings
* Track earnings
* Receive reviews

---

### B. WEDDINGS / ORGANIZERS

Users can create and manage wedding events.

A user can create an organizer identity/activity without creating a separate account.

Organizers can:

* Create an organizer profile
* Create wedding events
* Select wedding type
* Add event details
* Specify dancer requirements
* Set budget
* Receive dancer booking requests
* Manage bookings
* Check in dancers
* Complete events
* Manage payments
* Review dancers

The Weddings section should also allow users to discover different types of Indian weddings.

Example categories:

* Punjabi Wedding
* Rajasthani Wedding
* Gujarati Wedding
* Marwari Wedding
* Bengali Wedding
* South Indian Wedding
* North Indian Wedding
* Other Indian Wedding

Each wedding category contains relevant events.

Example:

Punjabi Wedding
→ Upcoming Punjabi Wedding Events
→ Event Details
→ Organizer Profile
→ Dancer Requirements
→ Booking/Participation information

---

### C. MIRAGE EXPERIENCE

Mirage is the cultural experience marketplace inside Nachoonrent.

Mirage allows people to discover and book authentic Indian wedding/cultural experiences.

Examples:

* Experience a Baraat
* Punjabi wedding experience
* Sangeet experience
* Mehndi experience
* Haldi experience
* Traditional Indian food experience
* Traditional dress experience
* Cultural ceremony experience

IMPORTANT:

Mirage in Phase 1 is an **experience marketplace**, not a complete tourism platform.

Do NOT build:

* Flights
* Hotels
* Visa services
* Airport transfers
* Travel packages
* Full travel agency functionality

Those belong to Phase 2.

Mirage should nevertheless be designed so that Phase 2 tourism features can later be added.

---

# 2. MOST IMPORTANT ACCOUNT ARCHITECTURE

Do NOT create separate accounts for Dancer, Organizer and Explorer.

There is only ONE USER ACCOUNT.

A single user can have multiple activities.

Example:

One user can simultaneously be:

* A dancer
* An organizer
* An event creator
* A Mirage host
* A customer who books dancers
* A person who books Mirage experiences

The architecture should therefore be:

USER ACCOUNT
→ General User Profile
→ Dancer Profile
→ Organizer/Event Activity
→ Mirage Activity
→ Bookings
→ Payments
→ Reviews

Never force the user to select one permanent role during signup.

---

# 3. MAIN APPLICATION NAVIGATION

Use four primary bottom navigation tabs:

## 1. DANCERS

Discover dancers and create a dancer profile.

## 2. WEDDINGS

Discover wedding types, wedding events and organizers, and create wedding events.

## 3. MY ACTIVITY

Central dashboard for everything the user is doing.

## 4. ME

General user profile and account management.

Bottom navigation:

Dancers | Weddings | My Activity | Me

Keep this navigation consistent throughout the app.

---

# 4. DANCERS TAB

## Dancers Home

Show:

* Search bar
* Filters
* Create My Dancer Profile
* Dance style categories
* Featured dancers
* Popular dancers
* Dancers near location
* Recommended dancers

Dance categories:

* Bollywood
* Bhangra
* Punjabi
* Rajasthani
* Gujarati
* Classical
* Folk
* Dance Groups
* Other

Each dancer card should contain:

* Profile image
* Optional video thumbnail
* Name
* Verification badge
* Location
* Dance style
* Rating
* Number of reviews
* Starting price
* Availability indicator

---

# 5. DANCER PUBLIC PROFILE

Create a detailed public profile.

Include:

* Profile photo
* Performance videos
* Photo gallery
* Name
* Verification badge
* Location
* Rating
* Reviews
* Experience
* Dance styles
* About
* Pricing
* Availability
* Social media
* Completed bookings
* Performance information

Primary CTA:

BOOK DANCER

Secondary:

SHARE

The organizer must be able to watch videos before booking.

Social media links are important because they allow organizers to discover more of the dancer's work.

---

# 6. CREATE DANCER PROFILE

Use a multi-step profile creation flow.

Steps:

1. Profile photo
2. Name
3. Location
4. Dance styles
5. About
6. Experience
7. Pricing
8. Availability
9. Photos
10. Performance videos
11. Social media
12. Preview
13. Publish

Allow users to edit their dancer profile later.

---

# 7. WEDDINGS HOME

The Weddings tab should be visually rich.

Top:

Search weddings, events or organizers.

Primary CTA:

CREATE EVENT

Then show:

## Wedding Types

Use image-based cards.

Examples:

Punjabi
Rajasthani
Gujarati
Marwari
Bengali
South Indian
North Indian
Other

Then:

## Upcoming Events

Each event card contains:

* Cover image
* Event name
* Wedding type
* Date
* Location
* Organizer
* Dancer requirements
* Event status

Then:

## Featured Organizers

Show organizer profiles.

Then:

## MIRAGE

Show a small section for cultural experiences.

Do NOT give Mirage a separate bottom navigation tab in Phase 1.

---

# 8. WEDDING TYPE PAGE

Example:

Punjabi Weddings

Show:

* Hero image
* Short description
* Cultural information
* Upcoming events
* Featured organizers
* Search/filter

Each event can be opened.

---

# 9. WEDDING EVENT DETAILS

Each event has its own page.

Show:

* Cover image
* Event name
* Wedding type
* Date
* Time
* Location
* Organizer
* About event
* Event schedule
* Expected crowd
* Dancer requirements
* Number of dancers required
* Dance styles required
* Budget
* Photos
* Videos
* Organizer profile
* Event status

Actions may include:

* Request booking
* View organizer
* Contact
* Share

---

# 10. CREATE WEDDING EVENT

Create a simple multi-step flow.

Steps:

1. Wedding type
2. Event name
3. Description
4. Date
5. Time
6. Location
7. Expected crowd
8. Dancer requirements
9. Number of dancers
10. Preferred dance style
11. Performance duration
12. Budget
13. Photos/videos
14. Cancellation rules
15. Review
16. Publish

Use clear progress indicators.

Make the process simple and mobile friendly.

---

# 11. ORGANIZER PROFILE

Organizers should have public profiles.

Organizer profile includes:

* Profile photo/logo
* Organizer name
* Verification
* Location
* About
* Rating
* Reviews
* Events organized
* Completed events
* Photos/videos
* Active events
* Mirage experiences hosted

Other users can discover and view organizer profiles.

Dancers should be able to understand who they are working with.

---

# 12. MY ACTIVITY

This is one of the most important screens.

It is the user's personal command center.

Show:

## Overview

* Upcoming activities
* Booking requests
* Upcoming bookings
* Earnings
* Notifications

## MY EVENTS

Events created by the user.

Show:

* Draft
* Published
* Upcoming
* Completed
* Cancelled

Each event should show booking requests.

Example:

Wedding Event
5 dancer requests
₹25,000 budget
Manage Event

## DANCER ACTIVITY

If the user has a dancer profile:

Show:

* New booking requests
* Accepted bookings
* Upcoming bookings
* Completed bookings
* Earnings
* Profile views

## MIRAGE ACTIVITY

If the user hosts experiences:

Show:

* Created experiences
* Guest bookings
* Upcoming experiences
* Completed experiences
* Earnings

## BOOKINGS

Show bookings where the user is the customer.

## PAYMENTS

Show:

* Pending
* Paid
* Refunds
* Payouts

## NOTIFICATIONS

Show important activity.

---

# 13. ME / USER PROFILE

This is the general personal account profile.

Show:

* Profile photo
* Name
* Location
* Verification
* About
* Contact information

Then activity shortcuts:

* My Dancer Profile
* My Organizer Activity
* My Events
* My Bookings
* My Mirage
* Saved
* Reviews
* Payments

Settings:

* Notifications
* Privacy
* Account
* Help & Support
* Terms
* Logout

This is NOT the same as the Dancer Profile.

The User Profile represents the person.

The Dancer Profile represents the person's professional dancer identity.

---

# 14. MIRAGE HOME

Mirage should feel premium and immersive.

Heading:

Experience India Beyond the Tourist Trail

Supporting text:

Discover authentic Indian celebrations and cultural experiences.

Categories:

* Baraat
* Sangeet
* Mehndi
* Haldi
* Traditional Food
* Traditional Dress
* Cultural Ceremony

Experience cards include:

* Large immersive image
* Experience name
* Location
* Duration
* Rating
* Price per person
* Host

---

# 15. MIRAGE EXPERIENCE DETAILS

Show:

* Photo/video gallery
* Experience title
* Location
* Rating
* Host
* Duration
* Price

Sections:

What You'll Experience
What's Included
What's Not Included
About the Host
Guest Rules
Available Dates
Reviews
Cancellation Policy

Primary CTA:

BOOK EXPERIENCE

---

# 16. CREATE MIRAGE EXPERIENCE

Eligible users can create a Mirage experience.

Steps:

1. Experience name
2. Category
3. Description
4. Location
5. Duration
6. Photos
7. Videos
8. Guest capacity
9. Available dates
10. Price per guest
11. What's included
12. What's not included
13. Guest rules
14. Cancellation policy
15. Review
16. Submit/publish

The system should support experience approval/verification.

---

# 17. BOOKING SYSTEM

Build ONE reusable booking engine that supports:

* Dancer bookings
* Mirage bookings

Booking lifecycle:

REQUESTED
→ ACCEPTED
→ PAYMENT
→ CONFIRMED
→ CHECK-IN
→ COMPLETED
→ REVIEW
→ PAYOUT

For bookings requiring host acceptance:

Customer sends request.

Host accepts.

Customer pays.

Booking becomes confirmed.

For applicable instant-book experiences, allow direct payment if configured.

---

# 18. PAYMENT PROTECTION

Payment logic is critical.

Do not simply mark money as paid to the dancer/host immediately.

Use a protected booking/settlement model.

Conceptually:

Customer books
→ Payment collected/protected
→ Booking confirmed
→ Event/experience occurs
→ Check-in/completion
→ Dispute window
→ Payout released

Show clear payment status to both sides.

The exact payment provider can be abstracted behind a payment service.

Build the architecture so a payment provider can be integrated later.

---

# 19. EVENT-DAY CHECK-IN

Dancer booking:

Organizer sees upcoming dancers.

Dancer arrives.

Dancer checks in.

Organizer confirms attendance.

Event completes.

Payout becomes eligible.

Mirage:

Guest arrives.

Guest shows booking QR/code.

Host scans/verifies.

Guest checks in.

Experience occurs.

Experience completes.

Review becomes available.

---

# 20. CANCELLATION / DISPUTE SYSTEM

Every booking should support:

* Cancel
* Cancellation reason
* Refund status
* Report problem
* Contact support
* Dispute

Examples of possible scenarios:

### Organizer cancels dancer

System applies the configured cancellation policy.

### Dancer cancels

System records cancellation and applies policy.

### Dancer does not show

Organizer can report no-show.

### Organizer denies payment after event

The booking/payment record and check-in/completion evidence should protect the dancer.

### Dancer claims event happened but organizer disputes it

Use booking status, check-in, completion confirmation and dispute workflow.

Do not rely solely on one party's statement.

---

# 21. NOTIFICATIONS

Central notification system.

Notification types:

* Booking request
* Booking accepted
* Payment required
* Payment successful
* Booking confirmed
* Event reminder
* Experience reminder
* Check-in
* Cancellation
* Refund
* Dispute
* Review request
* Payout
* New event
* Profile activity

---

# 22. SEARCH & FILTERS

Create reusable search/filter system.

Dancer filters:

* Location
* Dance style
* Price
* Rating
* Availability
* Solo/group
* Experience

Wedding filters:

* Wedding type
* Location
* Date
* Event status

Mirage filters:

* Category
* Location
* Date
* Price
* Duration
* Rating
* Availability

---

# 23. REVIEWS & RATINGS

After completed transactions:

Customer can review dancer/host.

Dancer/host can review customer/organizer where appropriate.

Reviews should be linked to verified completed bookings.

Show:

* Overall rating
* Rating breakdown
* Written reviews
* Reviewer
* Date
* Verified booking badge

Do not allow arbitrary reviews unrelated to completed transactions.

---

# 24. TRUST & VERIFICATION

Build a trust layer.

Profiles may have:

* Verified badge
* Completed booking count
* Rating
* Review count

Organizers may be verified.

Dancers may be verified.

Mirage experiences may be reviewed/approved.

Do not expose private verification information publicly.

---

# 25. DESIGN SYSTEM

Use a premium modern Indian design.

The product must feel like:

**Airbnb + creator marketplace + premium Indian hospitality**

NOT like:

* wedding invitation software
* matrimonial app
* old-fashioned Indian event website

## COLORS

Primary:
#4B164C Deep Plum

Secondary:
#E58A24 Saffron

Background:
#FFF9F2 Warm Ivory

Text:
#211F23 Charcoal

Secondary text:
#6F6A70

White:
#FFFFFF

Success:
#16805B Emerald

Warning:
#C87916

Error:
#C94A4A

Use color consistently.

Deep Plum:
Primary CTA, active navigation, important headings.

Saffron:
Highlights, cultural accents, selected states.

Emerald:
Success, confirmed, completed, check-in.

Warm Ivory:
Main background.

White:
Cards and elevated surfaces.

---

# 26. TYPOGRAPHY

Use:

Inter / Manrope / SF Pro.

Hierarchy:

Display:
32–36px bold

H1:
28–32px bold

H2:
22–24px semibold

H3:
18–20px semibold

Body:
15–16px

Small:
12–14px

Buttons:
15–16px semibold

Use strong whitespace and clear hierarchy.

---

# 27. UI COMPONENTS

Create reusable components.

Required components:

* Bottom navigation
* Top navigation
* Search bar
* Filter chips
* Category cards
* Dancer card
* Wedding card
* Organizer card
* Mirage experience card
* Profile header
* Rating
* Review
* Verification badge
* Price
* Status badge
* Primary button
* Secondary button
* Text field
* Dropdown
* Date picker
* Time picker
* Location selector
* Upload media
* Progress indicator
* Booking timeline
* Payment summary
* Notification
* Empty state
* Error state
* Loading state
* Modal
* Bottom sheet
* Confirmation dialog

Use reusable components instead of duplicating UI.

Use Auto Layout.

Use responsive constraints.

Use an 8px spacing system.

---

# 28. RESPONSIVE / MOBILE UX

Primary target:

Mobile application.

Design for:

390 × 844px

but use responsive layouts so it works on:

* smaller Android phones
* larger Android phones
* iPhones
* tablets where practical

Use:

* large touch targets
* sticky primary actions
* bottom sheets
* swipeable galleries
* horizontal category scrolling
* simple forms
* minimal typing

---

# 29. EMPTY STATES

Design useful empty states.

Examples:

No dancer profile:

“You haven't created your dancer profile yet.”

CTA:
Create Dancer Profile

No events:

“You haven't created an event yet.”

CTA:
Create Event

No bookings:

“No bookings yet.”

CTA:
Explore Dancers

No Mirage experiences:

“No experiences yet.”

CTA:
Explore Mirage

---

# 30. LOADING / ERROR STATES

Create skeleton loading states.

Do not leave screens blank.

Network error:

“Something went wrong.”

CTA:
Try Again

Payment error:

“Payment couldn't be completed.”

CTA:
Try Again

Booking error:

“Booking couldn't be completed.”

CTA:
Try Again

---

# 31. ONBOARDING

Do NOT force users to choose one permanent role.

Initial onboarding:

Splash
→ Welcome
→ Login/Sign Up
→ Basic User Profile
→ App Home

After entering the app, users can decide whether to:

Create Dancer Profile
Create Wedding Event
Explore Dancers
Explore Weddings
Explore Mirage

This is a critical product decision.

---

# 32. MAIN SCREEN FLOW

Implement these flows:

## FLOW A — DANCER

Dancers
→ Create Dancer Profile
→ Profile Setup
→ Publish
→ Public Profile
→ Receive Booking Request
→ Accept
→ Payment
→ Confirmed
→ Event Day
→ Check-in
→ Complete
→ Review
→ Payout

## FLOW B — ORGANIZER

Weddings
→ Create Event
→ Publish
→ Find Dancers
→ View Dancer Profile
→ Send Booking Request
→ Dancer Accepts
→ Payment
→ Confirmed
→ Event Day
→ Check-in
→ Complete
→ Review

## FLOW C — MIRAGE

Weddings
→ Mirage
→ Experience
→ Experience Details
→ Select Date
→ Guests
→ Payment
→ Confirmation
→ Event Day
→ QR Check-in
→ Experience
→ Review

## FLOW D — USER ACTIVITY

My Activity
→ Events
→ Booking Requests
→ Dancer Bookings
→ Mirage Activity
→ Payments
→ Notifications

---

# 33. PHASE 1 SCREEN LIST

Build the following screens.

### Onboarding

1. Splash
2. Welcome
3. Login
4. OTP
5. Basic User Profile

### Dancers

6. Dancers Home
7. Search
8. Filters
9. Dancer Profile
10. Create Dancer Profile
11. Edit Dancer Profile
12. Dancer Availability

### Weddings

13. Weddings Home
14. Wedding Type
15. Event Listing
16. Event Details
17. Organizer Profile
18. Create Event
19. Edit Event

### Mirage

20. Mirage Home
21. Experience Details
22. Create Experience
23. Edit Experience
24. Experience Booking

### My Activity

25. Activity Dashboard
26. My Events
27. Booking Requests
28. My Dancer Bookings
29. My Mirage Activity
30. Earnings
31. Notifications

### Booking

32. Booking Request
33. Booking Details
34. Payment
35. Payment Confirmation
36. Check-in
37. Completion
38. Review
39. Cancellation
40. Dispute/Support

### Me

41. User Profile
42. Saved
43. Payments
44. Settings
45. Help & Support

Also create:

* loading states
* empty states
* error states
* success states
* confirmation modals
* cancellation modals

---

# 34. IMPORTANT PRODUCT PRINCIPLES

1. One account can have multiple roles/activities.
2. Dancer profiles are public.
3. Organizer profiles are public.
4. Users can discover other dancers.
5. Users can discover organizers.
6. Users can create events.
7. Users can book dancers.
8. Dancers can accept/reject requests.
9. Payments must have protected status.
10. Check-in/completion is part of the booking lifecycle.
11. Reviews should be connected to completed bookings.
12. Mirage is an experience marketplace in Phase 1.
13. Tourism infrastructure belongs to Phase 2.
14. The app must feel premium and globally usable.
15. Keep Indian culture visually present but modern.
16. Do not overdecorate the interface.
17. Prioritize trust and transparency.
18. Build reusable components and scalable architecture.

---

# 35. PHASE 2 COMPATIBILITY

Do not implement Phase 2 now.

However, architect the application so future features can be added:

* International tourists
* Tourist profiles
* International payments
* Currency conversion
* Travel partners
* Hotels
* Transportation
* Airport pickup
* Local guides
* Travel packages
* International wedding tourism

Mirage should eventually become the bridge between:

TOURIST
→ MIRAGE EXPERIENCE
→ INDIAN WEDDING
→ CULTURAL EXPERIENCE
→ TRAVEL

But keep these features OUT of the Phase 1 MVP.

---

# 36. FINAL OUTPUT EXPECTATION

Do not produce a collection of disconnected mockups.

Build a coherent, clickable Phase 1 product.

The prototype should allow a user to:

1. Sign up.
2. Create a dancer profile.
3. Browse other dancers.
4. View dancer profiles.
5. Create a wedding event.
6. Browse wedding types.
7. View wedding events.
8. View organizer profiles.
9. Send/receive dancer booking requests.
10. Complete a booking/payment flow.
11. Check in.
12. Complete an event.
13. Review participants.
14. Discover Mirage.
15. View a Mirage experience.
16. Book a Mirage experience.
17. View all activities in My Activity.
18. Manage the general account through Me.

Use realistic sample content and images rather than placeholder boxes wherever possible.

Create a polished, high-fidelity, production-oriented mobile UI.

The final experience should feel like a **modern global marketplace built specifically around Indian wedding celebration and culture**.

Brand philosophy:

**NACHOONRENT**

**Celebrate. Connect. Experience.**
