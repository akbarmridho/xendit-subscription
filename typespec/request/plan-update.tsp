import "../model/plan.tsp";

namespace PlanUpdate {
    alias PaymentMethodDto = OmitProperties<PaymentMethod, "type">;

    model PlanDto {
        @doc("Xendit-generated customer ID, with prefix cust-xxx")
        customer_id?: string;

        @doc("ISO 4217 currency code of Subscriptions plan")
        currency?: CurrencyEnum;

        @doc("Amount that Subscriptions plan will charge to end users. Min - Rp 1000 (Indonesia) or PHP 50 (Philippines)")
        amount?: int32;

        @doc("Array of payment methods that the Subscriptions plan will attempt to make payments with")
        payment_methods?: PaymentMethodDto[];

        @doc("Object containing notification preferences for the Subscriptions plan")
        notification_config?: NotificationConfig;

        @doc("Indicates whether the plan should generate a payment link to be sent to the end customer when the first attempt of the cycle fails")
        payment_link_for_failed_attempt?: boolean;

        @doc("Object of additional information the merchants may use")
        metadata?: Record<unknown>;

        @doc("Description of Subscriptions plan.")
        @minLength(1)
        @maxLength(1000)
        description?: string;

        @doc("Array of objects describing the item/s")
        items?: Item[];

        @doc("The type of Subscriptions action requested")
        recurring_action: "PAYMENT";
    }
}
