CREATE TABLE "invoices"(
    "id" BIGINT NOT NULL,
    "total_amount" DECIMAL(8, 2) NOT NULL,
    "generated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "payed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "medical_history_id" INTEGER NOT NULL
);

CREATE INDEX "invoices_medical_history_id_index" ON
    "invoices"("medical_history_id");

ALTER TABLE
    "invoices" ADD PRIMARY KEY("id");


CREATE TABLE "patients"(
    "id" BIGINT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL
);

ALTER TABLE
    "patients" ADD PRIMARY KEY("id");

CREATE TABLE "treatments"(
    "id" BIGINT NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL
);

ALTER TABLE
    "treatments" ADD PRIMARY KEY("id");

CREATE TABLE "medical_histories"(
    "id" BIGINT NOT NULL,
    "admited_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "patient_id" INTEGER NOT NULL,
    "status" VARCHAR(255) NOT NULL
);

CREATE INDEX "medical_histories_patient_id_index" ON
    "medical_histories"("patient_id");

ALTER TABLE
    "medical_histories" ADD PRIMARY KEY("id");

CREATE TABLE "invoice_items"(
    "id" BIGINT NOT NULL,
    "unit_price" DECIMAL(8, 2) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "total_price" DECIMAL(8, 2) NOT NULL,
    "invoice_id" INTEGER NOT NULL,
    "treatment_id" INTEGER NOT NULL
);


CREATE INDEX "invoice_items_invoice_id_index" ON
    "invoice_items"("invoice_id");

CREATE INDEX "invoice_items_treatment_id_index" ON
    "invoice_items"("treatment_id");

-- join table

CREATE TABLE "medical_his_treatments"(
    "id_medical_his" BIGINT NOT NULL,
    "id_treatments" BIGINT NOT NULL
);

CREATE INDEX "medical_his_treatments_id_treatments_index" ON
    "medical_his_treatments"("id_treatments");

ALTER TABLE
    "medical_his_treatments" ADD PRIMARY KEY("id_medical_his", "id_treatments");

CREATE INDEX "medical_his_treatments_id_medical_his_index" ON
    "medical_his_treatments"("id_medical_his");

-- Foreing keys

ALTER TABLE
    "invoice_items" ADD PRIMARY KEY("id");

ALTER TABLE
    "medical_his_treatments" ADD CONSTRAINT "medical_his_treatments_id_treatments_foreign" FOREIGN KEY("id_treatments") REFERENCES "treatments"("id");

ALTER TABLE
    "invoices" ADD CONSTRAINT "invoices_medical_history_id_foreign" FOREIGN KEY("medical_history_id") REFERENCES "medical_histories"("id");

ALTER TABLE
    "invoice_items" ADD CONSTRAINT "invoice_items_invoice_id_foreign" FOREIGN KEY("invoice_id") REFERENCES "invoices"("id");

ALTER TABLE
    "medical_histories" ADD CONSTRAINT "medical_histories_patient_id_foreign" FOREIGN KEY("patient_id") REFERENCES "patients"("id");

ALTER TABLE
    "invoice_items" ADD CONSTRAINT "invoice_items_treatment_id_foreign" FOREIGN KEY("treatment_id") REFERENCES "treatments"("id");

ALTER TABLE
    "medical_his_treatments" ADD CONSTRAINT "medical_his_treatments_id_medical_his_foreign" FOREIGN KEY("id_medical_his") REFERENCES "medical_histories"("id");