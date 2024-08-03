import "./plan.tsp";
import "./cycle.tsp";

alias BaseCallback<Payload> = {
    event: string;
    business_id: string;
    created: utcDateTime;
    data?: Payload;
    api_version?: string;
};

alias PlanCallback = BaseCallback<Plan>;

alias CycleCallback = BaseCallback<Cycle>;
