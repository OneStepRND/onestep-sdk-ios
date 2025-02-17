## OneStep iOS SDK 1.2.0-rc
###### Release Date: 2025-02-13

### ⚠️ SDK interface changes:
* **HealthKit Capability:** The HealthKit capability must be enabled. It is recommended to request authorization for at least step count to ensure compatibility with OneStep features.
* **Background Tasks:** To enable background data sync, add the **"Background Fetch"** execution mode and register `"co.onestep.bgsync"` under **BGTaskSchedulerPermittedIdentifiers** in your app’s `Info.plist`.

### 🪄 Enhancements and fixes
* Data is now synced in the background (under certain constraints), reducing delays caused by waiting for the next app launch.
* HealthKit Integration: for daily step counter, walking bouts (experimental), and daily mobility parameters.
* Data sync strategy and background monitoring intensity are now configurable.

## OneStep iOS SDK 1.1.0
###### Release Date: 2024-10-08

### ⚠️ SDK interface changes:
* SDK initialization changed from async function to a regular function with completion handler
* OSTMotionMeasurement - Some integer values were changed to enums for more clear code
* ReadMotionMeasurements - added the ability to specify time scope by providing startTime and endTime parameters
* Moved to use UUIDs in all interface functions

### 🪄 Enhancements and fixes
* Fixed foreground recording possible start issue when a background one is in progress
* Prevent possible sync parallel execution

## OneStep iOS SDK 1.0.0
###### Release Date: 2024-08-29

* Initial version 1.0
