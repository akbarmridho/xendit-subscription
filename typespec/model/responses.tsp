import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

model ApiValidationErrorResponse {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body data: {
        error_code: "API_VALIDATION_ERROR";
        message: string;
    };
}

model InvalidPaymentMethodErrorResponse {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body data: {
        error_code: "INVALID_PAYMENT_METHOD_ID";
        message: string;
    };
}

model InvalidApiKeyErrorResponse {
    @statusCode statusCode: 401;
    @header contentType: "application/json";
    @body data: {
        error_code: "INVALID_API_KEY";
        message: string;
    };
}

model PaymentMethodIdNotFoundResponse {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body data: {
        error_code: "PAYMENT_METHOD_ID_NOT_FOUND";
        message: string;
    };
}

model CustomerNotFoundResponse {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body data: {
        error_code: "CUSTOMER_NOT_FOUND";
        message: string;
    };
}

alias PayloadResponse<Type> = {
    @statusCode statusCode: 200;
    @header contentType: "application/json";
    @body payload: Type;
};
