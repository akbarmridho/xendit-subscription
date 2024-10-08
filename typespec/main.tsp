import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "./request/plan-create.tsp";
import "./request/plan-update.tsp";
import "./request/cycles-update.tsp";
import "./request/schedule-update.tsp";
import "./model/responses.tsp";
import "./model/cycle.tsp";
import "./model/callback.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

@service({
    title: "Xendit Subscription API",
})
@server("https://api.xendit.co", "Xendit API endpoint")
@useAuth(BasicAuth)
namespace Xendit {
    @route("/recurring")
    namespace Subscription {
        @route("/plans")
        namespace Plans {
            @post
            op create(@body body: PlanCreate.PlanDto):
                | PayloadResponse<Plan>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | PaymentMethodIdNotFoundResponse
                | InvalidPaymentMethodErrorResponse
                | CustomerNotFoundResponse;

            @route("/{id}")
            @patch
            op update(
                @path id: string,
                @header `update-scheduled-cycle`?: "TRUE",
                @body body: PlanUpdate.PlanDto,
            ):
                | PayloadResponse<Plan>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | PaymentMethodIdNotFoundResponse
                | InvalidPaymentMethodErrorResponse
                | CustomerNotFoundResponse;

            @route("/{id}/deactivate")
            @post
            op deactivate(@path id: string):
                | PayloadResponse<Plan>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | DataNotFoundResponse;

            @route("/{id}")
            @get
            op fetchObject(@path id: string):
                | PayloadResponse<Plan>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | DataNotFoundResponse;

            @route("/{id}/cycles")
            @get
            op getCyclesList(
                @path id: string,
                @query limit?: int32,
                @query after_id?: string,
            ):
                | PayloadHasMoreResponse<Cycle[]>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | DataNotFoundResponse;
        }

        @route("/plans/{plan_id}/cycles")
        namespace Cycles {
            @route("/{id}")
            @patch
            op update(
                @path plan_id: string,
                @path id: string,
                @body body: CycleUpdate.CycleDto,
            ):
                | PayloadResponse<Cycle>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | IneligibleCycleRequestResponse
                | DataNotFoundResponse;

            @route("/{id}/cancel")
            @post
            op cancel(@path plan_id: string, @path id: string):
                | PayloadResponse<Cycle>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | IneligibleCycleRequestResponse
                | DataNotFoundResponse;

            @route("/{id}/force_attempt")
            @post
            op forceCycleAttempt(@path plan_id: string, @path id: string):
                | PayloadResponse<Cycle>
                | IneligibleCycleRequestResponse
                | MaximumLimitReachedResponse
                | DataNotFoundResponse;

            @route("/{id}")
            @get
            op fetchObject(@path plan_id: string, @path id: string):
                | PayloadResponse<Cycle>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | DataNotFoundResponse;
        }

        @route("/schedules")
        namespace Schedules {
            @route("/{id}")
            @patch
            op update(
                @path plan_id: string,
                @path id: string,
                @body body: ScheduleUpdate.ScheduleDto,
            ):
                | PayloadResponse<Schedule>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | DataNotFoundResponse;

            @route("/{id}")
            @get
            op fetchObject(@path id: string):
                | PayloadResponse<Schedule>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | DataNotFoundResponse;
        }
    }

    @doc("Not real endpoint. Just to include event callback types")
    namespace Utils {
        op test(
            @body body: {
                planCb: PlanCallback;
                cycleCb: CycleCallback;
            },
        ): string;
    }
}
