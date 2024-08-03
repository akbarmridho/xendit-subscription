import "./schedule.tsp";
import "./enum.tsp";
import "./payment-method.tsp";

enum PlanStatus {
    ACTIVE: "ACTIVE",
    INACTIVE: "INACTIVE",
    PENDING: "PENDING",
    REQUIRES_ACTION: "REQUIRES_ACTION",
}

enum FailedCycleActionEnum {
    RESUME: "RESUME",
    STOP: "STOP",
}

enum NotificationChannelEnum {
    WHATSAPP: "WHATSAPP",
    EMAIL: "EMAIL",
}

enum ItemTypeEnum {
    DIGITAL_PRODUCT: "DIGITAL_PRODUCT",
    PHYSICAL_PRODUCT: "PHYSICAL_PRODUCT",
    DIGITAL_SERVICE: "DIGITAL_SERVICE",
    PHYSICAL_SERVICE: "PHYSICAL_SERVICE",
    FEE: "FEE",
    DISCOUNT: "DISCOUNT",
}

@doc("Represents a Subscriptions plan")
model Plan {
    @doc("Xendit-generated Subscriptions plan ID, with prefix repl-xxx")
    id: string;

    @doc("Merchant-provided identifier for the Subscriptions plan.")
    @minLength(1)
    @maxLength(64)
    reference_id: string;

    @doc("Xendit-generated customer ID, with prefix cust-xxx")
    customer_id: string;

    @doc("The type of Subscriptions action requested")
    recurring_action: "PAYMENT";

    @doc("Total number of cycles the Subscriptions plan has executed. Immediate charge cycle also counts as 1 cycle count")
    recurring_cycle_count: int32;

    @doc("ISO 4217 currency code of Subscriptions plan")
    currency: CurrencyEnum;

    @doc("Amount that Subscriptions plan will charge to end users. Min - Rp 1000 (Indonesia) or PHP 50 (Philippines)")
    amount: int32;

    @doc("Status of Subscriptions plan")
    status: PlanStatus;

    @doc("ISO 8601 Timestamp for Subscriptions plan creation. Timezone UTC+0")
    created: utcDateTime;

    @doc("ISO 8601 Timestamp for latest plan object update. Timezone UTC+0")
    updated: utcDateTime;

    @doc("Array of payment methods that the Subscriptions plan will attempt to make payments with")
    payment_methods?: PaymentMethod[];

    @doc("Xendit-generated Subscriptions schedule ID")
    schedule_id?: string;

    @doc("Data object containing the configurations of how Subscriptions cycles will be scheduled")
    schedule: Schedule;

    @doc("The type of action the Subscriptions plan takes upon creation")
    immediate_action_type?: "FULL_AMOUNT";

    @doc("Object containing notification preferences for the Subscriptions plan")
    notification_config?: NotificationConfig;

    @doc("Indicates whether the plan should generate a payment link to be sent to the end customer when the first attempt of the cycle fails")
    payment_link_for_failed_attempt?: boolean;

    @doc("Indicate the behaviour the Subscriptions plan should take when Subscriptions cycles fail")
    failed_cycle_action?: FailedCycleActionEnum;

    @doc("Object of additional information the merchants may use")
    metadata?: Record<unknown>;

    @doc("Description of Subscriptions plan.")
    @minLength(1)
    @maxLength(1000)
    description?: string;

    @doc("Array of objects describing the item/s")
    items?: Item[];

    @doc("Array of objects that contain URLs for end users to complete their Subscriptions plan")
    actions?: Action[];

    @doc("URL where the end user is redirected after account linking has been successful")
    success_return_url?: string;

    @doc("URL where the end-customer is redirected if the account linking has failed")
    failure_return_url?: string;
}

@doc("Represents the notification configuration for a Subscriptions plan")
model NotificationConfig {
    @doc("Specify which channel you want to notify your end customer through when a Subscriptions plan is created")
    recurring_created?: NotificationChannelEnum[];

    @doc("Specify which channel you want to notify your end customer through when a Subscriptions cycle was successfully completed")
    recurring_succeeded?: NotificationChannelEnum[];

    @doc("Specify which channel you want to notify your end customer through when a Subscriptions cycle has failed")
    recurring_failed?: NotificationChannelEnum[];

    @doc("ISO 639-1: two-letter codes for language of notifications sent to end user")
    locale?: "en" | "id";
}

@doc("Represents an item in a Subscriptions plan")
model Item {
    @doc("Type of item")
    type: ItemTypeEnum;

    @doc("Item name.")
    @maxLength(255)
    name: string;

    @doc("Net amount to be charged per unit, please put negative amount for DISCOUNT")
    net_unit_amount: float64;

    @doc("Number of units of this item in the basket. Min 1")
    quantity: int32;

    @doc("URL of the item")
    url?: string;

    @doc("Merchant category for item.")
    @maxLength(255)
    category?: string;

    @doc("Merchant subcategory for item.")
    @maxLength(255)
    subcategory?: string;

    @doc("Item description.")
    @maxLength(255)
    description?: string;

    @doc("Additional object that may be used for additional item attributes")
    metadata?: Record<unknown>;
}

@doc("Represents an action for a Subscriptions plan")
model Action {
    @doc("Describes the purpose the corresponding action")
    action: "AUTH";

    @doc("Describes the type of URL provided")
    url_type?: "WEB";

    @doc("The generated URL to hit in order to perform the action")
    url?: string;

    @doc("HTTP method for calling the url")
    method?: "GET" | "POST";
}
