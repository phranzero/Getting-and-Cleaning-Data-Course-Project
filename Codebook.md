###Data Dictionary for ActivityData.txt

Original data set codebook is located here for information about data collection decisions, study design and original variables.
https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

The original data has been cleaned to measurement means and measurement standard deviations to observe differences in these measurement signals by subject and activity.  Grand means are generated for each of these measurements.

Many of the measurements have three fields corresponding to the X, Y, and Z axis.  These fields will not be described separately but noted with "3-axial" when the measurement exists for all 3 axis.
Each of these axial measurements will include "-onXAxis", "-onYAxis" or "-onZAxis" on the end of the respective field names in the data set.

Means of frequency domains calculations are also included in the data set.  These data were obtained by taking Fast Fourier Transforms of the time domain based measurements.

|: **Field Name** :|: **Data Attributes** :|: **Description** :|
|------------|-----------------|-------------|
|activity | character (factor) | The activity the subject was completing during the measurement.  Possible values can be *LAYING*, *SITTING*, *STANDING*, *WALKING*, *WALKING_DOWNSTAIRS* or *WALKING_UPSTAIRS*.|
subject | integer | represents unique ID of test subject completing the activity range [1,30] |
|TimeDomain-BodyAcceleration-Mean| Numeric, normalized [-1,1],3-axial  | the mean of linear body acceleration measured over time |
|TimeDomain-BodyAcceleration-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of the standard deviations of linear body acceleration measured over time |
|TimeDomain-GravityAcceleration-Mean| Numeric, normalized [-1,1],3-axial | the mean of linear acceleration due to gravity measured over time |
|TimeDomain-GravityAcceleration-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of the standard deviations of linear acceleration due to gravity measured over time |
|TimeDomain-BodyAccelerationJerk-Mean| Numeric, normalized [-1,1],3-axial | the mean of body acceleration measurements derived with respect to time |
|TimeDomain-BodyAccelerationJerk-StandardDev| Numeric, normalized [-1,1],3-axial |  the mean of standard deviations of body acceleration measurements derived with respect to time |
|TimeDomain-BodyAngularVelocity-Mean| Numeric, normalized [-1,1],3-axial | the mean of body angular velocity measurements taken from gyroscope measured over time |
|TimeDomain-BodyAngularVelocity-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of the standard deviations of body angular velocity measurements measured over time |
|TimeDomain-BodyAngularVelocityJerk-Mean| Numeric, normalized [-1,1],3-axial | the mean of body angular velocity measurements derived with respect to time |
|TimeDomain-BodyAngularVelocityJerk-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of standard deviations of body angular velocity measurements derived with respect to time |
|TimeDomain-BodyAccelerationDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from 3-axial linear body acceleration measured over time |
|TimeDomain-BodyAccelerationDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations of calculated magnitudes from 3-axial linear body acceleration measured over time |
|TimeDomain-GravityAccelerationDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from 3-axial linear acceleration from gravity measured over time |
|TimeDomain-GravityAccelerationDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations of calculated magnitudes from 3-axial linear acceleration from gravity measured over time |
|TimeDomain-BodyAccelerationJerkDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of magnitudes derived over time from the 3-axial linear body acceleration measurements |
|TimeDomain-BodyAccelerationJerkDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations for magnitudes derived over time from the 3-axial linear body acceleration measurements |
|TimeDomain-BodyAngularVelocityDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from 3-axial angular velocity measured over time |
|TimeDomain-BodyAngularVelocityDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations from calculated magnitudes of 3-axial angular velocity measured over time |
|TimeDomain-BodyAngularVelocityJerkDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of magnitudes derived over time from the 3-axial angular velocity measurements |
|TimeDomain-BodyAngularVelocityJerkDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations of magnitudes derived over time from the 3-axial angular velocity measurements |
|FrequencyDomainBodyAcceleration-Mean| Numeric, normalized [-1,1],3-axial | the mean of FFT calculations on linear body acceleration measurements |
|FrequencyDomainBodyAcceleration-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of standard deviations on FFT calculations of linear body acceleration measurements |
|FrequencyDomainBodyAccelerationJerk-Mean| Numeric, normalized [-1,1],3-axial | the mean of FFT calculations on linear body acceleration measurements derived over time |
|FrequencyDomainBodyAccelerationJerk-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of standard deviations from FFT calculations on linear body acceleration measurements derived over time |
|FrequencyDomainBodyAngularVelocity-Mean| Numeric, normalized [-1,1],3-axial | the mean of FFT calculations on angular velocity measurements |
|FrequencyDomainBodyAngularVelocity-StandardDev| Numeric, normalized [-1,1],3-axial | the mean of standard deviations for FFT calculations on angular velocity measurements |
|FrequencyDomainBodyAccelerationDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from FFT of 3-axial linear body acceleration measurements |
|FrequencyDomainBodyAccelerationDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations of calculated magnitudes from FFT of 3-axial linear body acceleration measurements |
|FrequencyDomainBodyBodyAccelerationJerkDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from FFT of 3-axial linear body acceleration measurements derived over time |
|FrequencyDomainBodyBodyAccelerationJerkDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations for calculated magnitudes from FFT of 3-axial linear body acceleration measurements derived over time |
|FrequencyDomainBodyBodyAngularVelocityDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from FFT of 3-axial body angular velocity measurements |
|FrequencyDomainBodyBodyAngularVelocityDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations for calculated magnitudes from FFT of 3-axial body angular velocity measurements |
|FrequencyDomainBodyBodyAngularVelocityJerkDMagnitude-Mean| Numeric, normalized [-1,1] | the mean of calculated magnitudes from FFT of 3-axial body angular velocity measurements derived over time |
|FrequencyDomainBodyBodyAngularVelocityJerkDMagnitude-StandardDev| Numeric, normalized [-1,1] | the mean of standard deviations for calculated magnitudes from FFT of 3-axial body angular velocity measurements derived over time |