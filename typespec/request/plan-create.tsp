import "../model/plan.tsp";

namespace PlanCreate {
    // alias ScheduleDto = OmitProperties<
    //     Schedule,
    //     "id" | "business_id" | "created" | "updated"
    // >;

    model ScheduleDto {
        @doc("Merchant-provided identifier for the schedule")
        reference_id: string;

        @doc("The type of interval between consecutive Subscriptions cycles")
        interval: ScheduleIntervalEnum;

        @doc("The number of units of interval between consecutive Subscriptions cycles")
        interval_count: int32;

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

    alias PaymentMethodDto = OmitProperties<PaymentMethod, "type">;

    model PlanDto
        extends OmitProperties<
            Plan,

                | "id"
                | "recurring_cycle_count"
                | "status"
                | "created"
                | "updated"
                | "schedule_id"
                | "payment_methods"
                | "schedule"
        > {
        payment_methods?: PaymentMethodDto[];
        schedule: ScheduleDto;
    }
}
