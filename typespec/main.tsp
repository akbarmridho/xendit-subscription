import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";
import "./request/plan-create.tsp";
import "./model/responses.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

@service({
    title: "Xendit Subscription API",
})
@server("https://api.xendit.co", "Xendit API endpoint")
namespace Xendit {
    @route("/recurring")
    namespace Subscription {
        namespace Plans {
            @route("/plans")
            @post
            op create(@body body: PlanCreate.PlanDto):
                | PayloadResponse<Plan>
                | ApiValidationErrorResponse
                | InvalidApiKeyErrorResponse
                | PaymentMethodIdNotFoundResponse
                | InvalidPaymentMethodErrorResponse
                | CustomerNotFoundResponse;
        }
    }
}
