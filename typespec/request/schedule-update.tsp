import "../model/plan.tsp";

namespace ScheduleUpdate {
    model ScheduleDto {
        interval?: ScheduleIntervalEnum;
        interval_count?: int32;
        total_recurrence?: null | int32;
        anchor_date?: utcDateTime;
        retry_interval?: "DAY";
        retry_interval_count?: int32;

        @minValue(1)
        @maxValue(10)
        total_retry?: int32;

        @doc("Specify which retry attempts will have failed Subscriptions notifications to the end user")
        failed_attempt_notifications?: int32[];
    }
}
