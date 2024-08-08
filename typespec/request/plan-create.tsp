import "../model/plan.tsp";

namespace PlanCreate {
    alias ScheduleDto = OmitProperties<
        Schedule,
        "id" | "business_id" | "created" | "updated"
    >;

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
        schedule?: ScheduleDto;
    }
}
