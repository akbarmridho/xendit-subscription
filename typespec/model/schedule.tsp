enum ScheduleIntervalEnum {
    DAY: "DAY",
    WEEK: "WEEK",
    MONTH: "MONTH",
}

@doc("Represents the schedule configuration for a Subscriptions plan")
model Schedule {
    @doc("Xendit-generated Subscriptions schedule ID")
    id?: string;

    @doc("Merchant-provided identifier for the schedule")
    reference_id: string;

    @doc("Xendit-generated identifier for the business")
    business_id?: string;

    @doc("The type of interval between consecutive Subscriptions cycles")
    interval: ScheduleIntervalEnum;

    @doc("The number of units of interval between consecutive Subscriptions cycles")
    interval_count: int32;

    @doc("ISO 8601 Timestamp for recurring schedule creation. Timezone UTC+0")
    created: utcDateTime;

    @doc("ISO 8601 Timestamp for latest schedule object update. Timezone UTC+0")
    updated: utcDateTime;

    @doc("The total number of times the end user will be charged")
    total_recurrence?: int32 | null;

    @doc("Timestamp in ISO 8601 used to determine when a Subscriptions plan starts")
    anchor_date?: utcDateTime;

    @doc("The type of interval between failed attempt and retries")
    retry_interval?: "DAY";

    @doc("The number of units of retry_interval between consecutive retries")
    retry_interval_count?: int32;

    @doc("The number of times you will retry a failed Subscriptions cycle.")
    @minValue(1)
    @maxValue(10)
    total_retry?: int32;

    @doc("Specify which retry attempts will have failed Subscriptions notifications to the end user")
    failed_attempt_notifications?: int32[];
}
