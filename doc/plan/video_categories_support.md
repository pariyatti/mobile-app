# Updated Plan: Supporting Video Categories, Search, and Sorting

This document outlines the end-to-end technical strategy for implementing video categorization, search, and sorting. It addresses gaps identified in PR #171 and aligns with requirements from issues #169, #165, #164, and kosa2 #31.

## 1. Backend: `kosa2` (Rails API)

The backend maintains the master list of videos, syncs with Vimeo, and serves categorized data.

### 1.1 `XlsxUpdatable` Concern Fixes
- **Update Descriptions**: Modify `kosa:videos:update_from_xlsx` to:
    - Read the `Description` column from the spreadsheet.
    - Sanitize it by removing "coded content" (e.g., HTML tags or internal tracking strings).
    - Update both the local database and the Vimeo API.
- **Fix Vimeo API Push**: Resolve the `TODO` in `XlsxUpdatable`.
    - Ensure the `vimeo_me2` gem correctly pushes `name`, `description`, and `tags` (including `category:xxx`) to Vimeo.
- **Category Extraction**: Update `Video.sync_all!` (Vimeo -> DB) to parse the `category:xxx` tag back into the `category` column.

### 1.2 API Enhancement
- **Expose Fields**: Update `VideosController` and the `Video` model to include `category` and `release_time` (or `created_time`) in the JSON response for `api/v1/library/videos.json`.
- **Sorting**: Default the API response to descending `release_time`.

## 2. Frontend: `mobile-app` (Flutter)

### 2.1 Review of PR #171 (Mergability)
- **Status**: **Do not merge as-is.**
- **Issues**:
    - Uses hardcoded categories ("Pali", "Vipassana") instead of spreadsheet-defined ones.
    - Filter logic is unimplemented (buttons don't filter).
    - Inconsistent I18n keys.
    - `createdAt` parsing crashes on `Video.RECOMMENDED` (empty string).

### 2.2 Model & Data Layer
- **Update `lib/model/Video.dart`**:
    - Add `final String category;` and `final DateTime releaseTime;`.
    - Update `Video.fromJson` to handle these fields and provide safe defaults for `Video.RECOMMENDED`.
- **I18n Standards**: Refactor `lib/app/I18n.dart`:
    - Use `all_lowercase_underscores` (e.g., `no_videos_found`, `search_videos_hint`, `sort_alphabetical`).
    - Use "Portuguese" instead of "Brazilian Portuguese".

### 2.3 UI Refinement (`LibraryScreen.dart`)
- **Horizontal Category Scroll**: Replace `Wrap` with a `SingleChildScrollView` + `Row`.
- **Dynamic Categories**: Fetch unique categories from the video list dynamically, plus an "All" option.
- **Filter & Search Logic**: 
    - Implement a `filteredVideos` list that updates on category selection or search query change.
    - Search should use `contains` (case-insensitive) rather than `startsWith`.
- **Sorting Logic**: Correctly sort by alphabetical (title) and chronological (`releaseTime`) order.

## 3. Data Migration & Validation Sequence

1.  **Stage Data**: Place master `vimeo.xlsx` in `kosa2/tmp/vimeo_latest_with_categories.xlsx`.
2.  **Import**: Run `rake kosa:videos:update_from_xlsx`.
3.  **Validate Sync**: Run `rake kosa:videos:sanity_update_from_xlsx` to verify Vimeo updates.
4.  **App Verification**:
    - Categories scroll horizontally.
    - Selection filters the list correctly.
    - Search and sort work without crashes.

---
**Next Implementation Step**: Fix the Backend `XlsxUpdatable` logic to ensure data integrity before proceeding to UI changes.
