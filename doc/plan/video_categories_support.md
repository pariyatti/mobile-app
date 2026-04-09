# Plan: Support Video Categories in Mobile App and kosa2 API

This plan outlines the changes required to support video categories, search, and sorting in the Pariyatti mobile app and the kosa2 Rails API, based on the requirements in issues #169, #165, #164 and kosa2 #31.

## 1. kosa2 (Rails API) Changes

### 1.1 Update Vimeo Sync Logic
- **Fix `XlsxUpdatable`**: The `TODO` in `app/models/concerns/xlsx_updatable.rb` indicates that `vimeo_video.update` might not be pushing tags correctly. 
    - Investigate the `vimeo_me2` fork to confirm the correct way to update tags.
    - Ensure `category:#{category_str}` and `tag:#{tag_str}` are properly pushed to Vimeo.
- **Sanitize Descriptions**: Update `Video.to_video` or the XLSX import logic to sanitize descriptions by removing "coded content" and handling empty values.

### 1.2 API Enhancements
- **JSON Response**: Update the `Video` model or controller to ensure the `category` field is included in the JSON response for `api/v1/library/videos.json`.
- **Filtering (Optional but Recommended)**: Consider adding a `category` parameter to the index action to allow server-side filtering, although frontend filtering is acceptable for small datasets.

## 2. mobile-app (Flutter) Changes

### 2.1 Review and Improve PR #171
- **Model Update (`lib/model/Video.dart`)**:
    - Add the `category` field to the `Video` class.
    - Update `Video.fromJson` to parse the `category` field from the API response.
- **I18n Cleanup (`lib/app/I18n.dart`)**:
    - Standardize new keys to use `all_lowercase_underscores` (e.g., `no_videos_found`, `search_videos_hint`, `sort_a_z`).
    - Remove trailing dots from keys.
- **UI Enhancements (`lib/ui/screens/library/LibraryScreen.dart`)**:
    - **Horizontal Category Scrolling**: Replace the `Wrap` widget with a `SingleChildScrollView` containing a `Row` of category buttons.
    - **Canonical Categories**: Use the required categories: `All`, `Audiobooks`, `Interviews`, `Movies`, `Talks` (or fetch unique categories from the video list).
    - **Search Logic**: Ensure `_onSearchTextChanged` matches the query anywhere in the title, not just at the start.
    - **Sorting**: Verify that "Newest" sorting uses the `release_time` or `createdAt` field correctly.

### 2.2 Integration
- Ensure the app correctly handles the case where a video might not have a category assigned yet.
- Match the visual style of the category buttons to the existing app theme.

## 3. Data Migration & Validation
1. **Upload Spreadsheet**: Use the provided `vimeo.xlsx` to update `kosa2` and Vimeo using the `kosa:videos:update_from_xlsx` Rake task.
2. **Sync and Verify**: Run `kosa:videos:sync` to pull the latest data back into the local database and `kosa:videos:sanity_update_from_xlsx` to verify the Vimeo update was successful.
3. **App Testing**: Verify that the mobile app correctly displays categories and filters videos as expected.
