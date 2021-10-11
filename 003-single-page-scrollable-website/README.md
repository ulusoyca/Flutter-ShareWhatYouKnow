<h2 align="center">003 - SINGLE PAGE SCROLLABLE WEBSITE WITH NAVIGATOR 2.0</h2>

<a href= "https://medium.com/flutter-community/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-1-introduction-c219b471bbec">Flutter for Single-Page Scrollable Websites with Navigator 2.0 — Part 1: Introduction</a>

<p>Single page scrollable websites are everywhere. In this website design pattern, all the content is presented in one long-scrolling layout that contains multiple sections. Visitors can scroll or jump to a section by clicking buttons of a sticky menu. This pattern is a good fit for small content such as brochure websites, software library documentation, portfolios, and landing pages that are used to convert users. Designers also love this pattern because it is simple, clean, and enables cool scroll animations.</p>
<p>In this series of articles, we will explore how to build a single-page scrollable website using Flutter. We will benefit from the Navigator 2.0 API to provide a good navigation experience to the users.</p>
<p>
We want to achieve the following goals for our single page scrollable website samples:
<li>Clicking a button in the top or side navigation menu bar will scroll the page to the
corresponding section</li>
<li>The URL on the Web browser’s address bar should be updated according to the button clicks on
the navigation menu and the first visible section as the user scrolls on the home page.</li>
<li>When the user enters a URL on the address bar, the Web application should show the corresponding section.</li>
<li>When the Web browser’s back and forward buttons are clicked the URL on the address bar and the first visible section should be updated correctly.</li>
<li>If the user types an unknown path in the address bar, a page with an error text is shown to the user.</li>
</p>
<br/>
<br/>

### PART 2: Scroll To Position

<a href= "https://levelup.gitconnected.com/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-2-scroll-to-position-4c09cbc9d975">Flutter for Single-Page Scrollable Websites with Navigator 2.0 — Part 2: Scroll To Position</a>

<p>In the first sample app, we will build the scrollable content using the ListView.builder constructor. Calling this method creates a ListView whose items are created lazily (on-demand). The itemBuilder parameter creates an item for a given index and it is called when the index is visible as the user scrolls onto the screen.</p>
<br/>

![singlePageWebsite_01.gif](../screenshot/singlePageWebsite_01.gif)

#### Usage (Part-2):
To start the app with the command line type the following commands on the command line:

```
003-single-page-scrollable-website && flutter run -d chrome lib/003-01-scroll-to-position/main_003_01.dart
```
<br/>
<br/>

### PART 3: Scroll to Page

<a href= "https://medium.com/geekculture/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-3-scroll-to-page-30b6c43bd41">Flutter for Single-Page Scrollable Websites with Navigator 2.0 — Part 3: Scroll to Page</a>

<p>The second sample app is very similar to the first sample app. In this sample, we will use PageView instead of ListView . PageView widget is a scrollable list whose children have the same size which is equal to the viewport size by default. Each item in the list is called a page. We can consider the PageView widget as a ListView but more tailored for items of equal size.</p>
<br/>

![singlePageWebsite_02.gif](../screenshot/singlePageWebsite_02.gif)

#### Usage (Part-3):
To start the app with the command line type the following commands on the command line:

```
cd 003-single-page-scrollable-website && flutter run -d chrome lib/003-02-scroll-to-page/main_003_02.dart
```
<br/>
<br/>

### PART 4: Ensure Visible

<a href= "https://ulusoyca.medium.com/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-4-ensure-visible-145eba88d742">Flutter for Single-Page Scrollable Websites with Navigator 2.0 — Part 4: Ensure Visible</a>

<p>In the third sample app, we will learn how to live with the expense of laying out all the list items with various heights. We will use SingleChildScrollView which is a scrollable box usually used with a Column . To achieve the scroll requirements, we will do the following:</p>
   <li>Create a widget list containing all the color section widgets.</li>
   <li>Assign a GlobalKey to each section widget.</li>
   <li>Set the color section widget list as the children of the Column widget and provide the Column to the SingleChildScrollView as its child.</li>
   <li>When we want to scroll to an index programmatically, we will get the GlobalKey of the color section widget and provide the currentContext of the GlobalKey as a parameter to Scrollable.</li>
<p>The ensureVisible method ensures that the widget with the given context is visible.</p>
<p>Note that this way of scrolling to an item is the most expensive one among all options in terms of performance. If the number of the sections are small, and the sections are not content-heavy, using SingleChildScrollView + Column could be the easiest solution.</p>
<br/>

![singlePageWebsite_03.gif](../screenshot/singlePageWebsite_03.gif)

#### Usage (Part-4):
To start the app with the command line type the following commands on the command line:

```
cd 003-single-page-scrollable-website && flutter run -d chrome lib/003-03-ensure-visible/main_003_03.dart
```
<br/>
<br/>

### PART 5: Scroll To Index

<a href= "https://ulusoyca.medium.com/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-5-scroll-to-index-c38ed06ddf08">Flutter for Single-Page Scrollable Websites with Navigator 2.0 — Part 5: Scroll To Index</a>

<p>In the previous samples, we utilized Flutter’s built-in solutions for creating a list of sections either lazily or at once. There is still a less expensive way of laying out the list items with unpredictable height on-demand (lazily) and scroll to an index thanks to the Scrollable Positioned List library by google.dev.</p>
   This library solves jumping to a section that has not yet laid out in a very clever way:
   <li>If the destination section index is too far from the current index (not yet laid out), the widget uses a new list in addition to the current one.</li>
   <li>The scrolling is started in both lists at the same pace.</li>
   <li>The newly created list fades over the old list and starts showing the items that are close to the target.</li>
   <li>When the scrolling reaches the target, the newly created list is already fully visible and stops.</li>
   <li>The offset of the new list is set to 0 and the old list becomes invisible.</li>
<br/>

![singlePageWebsite_04.gif](../screenshot/singlePageWebsite_04.gif)

#### Usage (Part-5):
To start the app with the command line type the following commands on the command line:

```
cd 003-single-page-scrollable-website && flutter run -d chrome lib/003-04-scroll-to-index/main_003_04.dart
```
<br/>
<br/>

### PART 7: Query Params

<a href= "https://ulusoyca.medium.com/flutter-for-single-page-scrollable-websites-with-navigator-2-0-part-7-query-params-deb0acfe09fa">Flutter for Single-Page Scrollable Websites with Navigator 2.0 — Part 7: Query Params</a>

<p>In the last 4 sample apps, we use path segments with path variables in URLs:</p>
<li>constant colors text as the first path segment</li>
<li>a path variable that stands for hex color code as the second path segment</li>
<li>a shape border type path variable as the third segment</li>

```
http://localhost:57155/colors/ffeb3b/circle
```

<p>In the fifth sample app, we will use query parameters in URLs with one path segment called section which contains two query parameters color and borderType.</p>

```
http://localhost:57073/section?color=ffeb3b&borderType=circle
```

<br/>

![singlePageWebsite_05.gif](../screenshot/singlePageWebsite_05.gif)

#### Usage (Part-7):
To start the app with the command line type the following commands on the command line:

```
cd 003-single-page-scrollable-website && flutter run -d chrome lib/003-05-query-params/main_003_05.dart
```