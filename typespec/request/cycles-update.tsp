import "../model/plan.tsp";

namespace CycleUpdate {
    model CycleDto {
        scheduled_timestamp?: utcDateTime;
        currency?: CurrencyEnum;
        amount?: int32;
    }
}
