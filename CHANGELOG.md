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
