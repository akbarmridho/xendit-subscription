import "./plan.tsp";
import "./cycle.tsp";

model BaseCallback<Payload> {
    event: string;
    business_id: string;
    created: utcDateTime;
    data?: Payload;
    api_version?: string;
}

model PlanCallback extends BaseCallback<Plan> {}

model CycleCallback extends BaseCallback<Cycle> {}
