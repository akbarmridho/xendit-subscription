import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi3";

using TypeSpec.Http;
using TypeSpec.Rest;

@error
model ApiValidationErrorResponse {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body data: {
        error_code: "API_VALIDATION_ERROR";
        message: string;
    };
}

@error
model InvalidPaymentMethodErrorResponse {
    @statusCode statusCode: 400;
    @header contentType: "application/json";
    @body data: {
        error_code: "INVALID_PAYMENT_METHOD_ID";
        message: string;
    };
}

@error
model InvalidApiKeyErrorResponse {
    @statusCode statusCode: 401;
    @header contentType: "application/json";
    @body data: {
        error_code: "INVALID_API_KEY";
        message: string;
    };
}

@error
model PaymentMethodIdNotFoundResponse {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body data: {
        error_code: "PAYMENT_METHOD_ID_NOT_FOUND";
        message: string;
    };
}

@error
model CustomerNotFoundResponse {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body data: {
        error_code: "CUSTOMER_NOT_FOUND";
        message: string;
    };
}

@error
model DataNotFoundResponse {
    @statusCode statusCode: 404;
    @header contentType: "application/json";
    @body data: {
        error_code: "DATA_NOT_FOUND";
        message: string;
    };
}

@error
model IneligibleCycleRequestResponse {
    @statusCode statusCode: 403;
    @header contentType: "application/json";
    @body data: {
        error_code: "INELIGIBLE_CYCLE_REQUEST";
        message: string;
    };
}

@error
model MaximumLimitReachedResponse {
    @statusCode statusCode: 403;
    @header contentType: "application/json";
    @body data: {
        error_code: "MAXIMUM_LIMIT_REACHED";
        message: string;
    };
}

alias PayloadResponse<Type> = {
    @statusCode statusCode: 200;
    @header contentType: "application/json";
    @body payload: Type;
};

alias PayloadHasMoreResponse<Type> = {
    @statusCode statusCode: 200;
    @header contentType: "application/json";
    @body payload: {
        data: Type;
        has_more: boolean;
    };
};
