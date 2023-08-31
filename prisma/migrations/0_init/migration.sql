-- CreateEnum
CREATE TYPE "config_type" AS ENUM ('TEXT', 'NUMBER', 'EMAIL', 'SELECT', 'TEXTAREA', 'CHECKBOX', 'RADIO');

-- CreateEnum
CREATE TYPE "request_repair_type" AS ENUM ('LOCAL', 'OUTDOOR');

-- CreateTable
CREATE TABLE "config" (
    "id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "value" TEXT,
    "description" VARCHAR(255) NOT NULL DEFAULT '',
    "type" "config_type" NOT NULL DEFAULT 'TEXT',
    "options" TEXT,

    CONSTRAINT "idx_146020_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer" (
    "id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "old_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "company" VARCHAR(255),
    "nip" VARCHAR(255),
    "email" VARCHAR(32) NOT NULL,
    "phone" VARCHAR(32) NOT NULL,
    "street" VARCHAR(255) NOT NULL,
    "number" VARCHAR(32) NOT NULL,
    "postcode" VARCHAR(16) NOT NULL,
    "last_request_date" DATE,
    "add_time" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_time" TIMESTAMPTZ(6),
    "city" VARCHAR(255) NOT NULL,

    CONSTRAINT "idx_146029_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(32) NOT NULL,

    CONSTRAINT "idx_146037_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipment" (
    "id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "model_id" INTEGER NOT NULL,
    "serial_number" VARCHAR(255) NOT NULL DEFAULT '',
    "product_code" VARCHAR(255) NOT NULL DEFAULT '',

    CONSTRAINT "idx_146044_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipment_model" (
    "id" SERIAL NOT NULL,
    "manufacturer_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "idx_146053_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipment_model_category" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "idx_146058_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "manufacturer" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "idx_146063_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "part" (
    "id" SERIAL NOT NULL,
    "manufacturer_id" INTEGER NOT NULL,
    "code" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "default_net_price" DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT "idx_146068_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "part_service_price" (
    "id" SERIAL NOT NULL,
    "part_id" INTEGER NOT NULL,
    "service_id" INTEGER NOT NULL,
    "default_net_price" DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT "idx_146076_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photos" (
    "id" SERIAL NOT NULL,
    "filename" TEXT NOT NULL,
    "description" TEXT,
    "add_time" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "is_archived" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "idx_146082_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "request" (
    "id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "status_id" INTEGER NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "equipment_id" INTEGER NOT NULL,
    "number" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "street" VARCHAR(255) NOT NULL,
    "street_number" VARCHAR(255) NOT NULL,
    "postcode" VARCHAR(255) NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL,
    "drive_net_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "repair_net_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "parts_net_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "total_net_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "drive_gross_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "repair_gross_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "parts_gross_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "total_gross_cost" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "failure_description" TEXT NOT NULL,
    "repair_type" "request_repair_type" NOT NULL DEFAULT 'LOCAL',
    "repair_description" TEXT NOT NULL,
    "add_time" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "accept_time" TIMESTAMPTZ(6),
    "complete_time" TIMESTAMPTZ(6),
    "archive_time" TIMESTAMPTZ(6),
    "repair_due_date" DATE,
    "update_time" TIMESTAMPTZ(6),

    CONSTRAINT "idx_146091_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "request_activity" (
    "id" SERIAL NOT NULL,
    "request_id" INTEGER NOT NULL,
    "activity_name" VARCHAR(1024) NOT NULL,

    CONSTRAINT "idx_146108_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "request_part" (
    "id" SERIAL NOT NULL,
    "request_id" INTEGER NOT NULL,
    "part_id" INTEGER NOT NULL,
    "net_price" DECIMAL(10,2) NOT NULL,
    "gross_price" DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    "amount" INTEGER NOT NULL,
    "net_value" DECIMAL(10,2) NOT NULL,
    "gross_value" DECIMAL(10,2) NOT NULL DEFAULT 0.00,

    CONSTRAINT "idx_146115_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "request_serviceman" (
    "request_id" INTEGER NOT NULL,
    "serviceman_id" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "request_status" (
    "id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "is_new" BOOLEAN NOT NULL DEFAULT false,
    "is_accepted" BOOLEAN NOT NULL DEFAULT false,
    "is_in_service" BOOLEAN NOT NULL DEFAULT false,
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "is_canceled" BOOLEAN NOT NULL DEFAULT false,
    "is_archived" BOOLEAN NOT NULL DEFAULT false,
    "color" VARCHAR(32) NOT NULL DEFAULT '#000000',

    CONSTRAINT "idx_146125_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "service" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "domain" VARCHAR(255) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "add_time" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "update_time" TIMESTAMPTZ(6),

    CONSTRAINT "idx_146137_primary" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "serviceman" (
    "id" SERIAL NOT NULL,
    "service_id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "surname" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(255) NOT NULL DEFAULT '',
    "email" VARCHAR(255) NOT NULL DEFAULT '',

    CONSTRAINT "idx_146146_primary" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_146020_service_id" ON "config"("service_id");

-- CreateIndex
CREATE INDEX "idx_146029_service_id" ON "customer"("service_id");

-- CreateIndex
CREATE INDEX "idx_146044_model_id" ON "equipment"("model_id");

-- CreateIndex
CREATE INDEX "idx_146044_service_id" ON "equipment"("service_id");

-- CreateIndex
CREATE INDEX "idx_146053_category_id" ON "equipment_model"("category_id");

-- CreateIndex
CREATE INDEX "idx_146053_manufacturer_id" ON "equipment_model"("manufacturer_id");

-- CreateIndex
CREATE INDEX "idx_146068_manufacturer_id" ON "part"("manufacturer_id");

-- CreateIndex
CREATE INDEX "idx_146076_part_id" ON "part_service_price"("part_id");

-- CreateIndex
CREATE INDEX "idx_146076_service_id" ON "part_service_price"("service_id");

-- CreateIndex
CREATE INDEX "idx_146091_customer_id" ON "request"("customer_id");

-- CreateIndex
CREATE INDEX "idx_146091_model_id" ON "request"("equipment_id");

-- CreateIndex
CREATE INDEX "idx_146091_service_id" ON "request"("service_id");

-- CreateIndex
CREATE INDEX "idx_146091_status_id" ON "request"("status_id");

-- CreateIndex
CREATE INDEX "idx_146108_request_id" ON "request_activity"("request_id");

-- CreateIndex
CREATE INDEX "idx_146115_part_id" ON "request_part"("part_id");

-- CreateIndex
CREATE INDEX "idx_146115_request_id" ON "request_part"("request_id");

-- CreateIndex
CREATE INDEX "idx_146121_request_id" ON "request_serviceman"("request_id");

-- CreateIndex
CREATE INDEX "idx_146121_serviceman_id" ON "request_serviceman"("serviceman_id");

-- CreateIndex
CREATE INDEX "idx_146125_service_id" ON "request_status"("service_id");

-- CreateIndex
CREATE INDEX "idx_146146_service_id" ON "serviceman"("service_id");

-- AddForeignKey
ALTER TABLE "config" ADD CONSTRAINT "config_ibfk_1" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer" ADD CONSTRAINT "customer_ibfk_1" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipment" ADD CONSTRAINT "equipment_ibfk_1" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipment" ADD CONSTRAINT "equipment_ibfk_3" FOREIGN KEY ("model_id") REFERENCES "equipment_model"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipment_model" ADD CONSTRAINT "equipment_model_ibfk_1" FOREIGN KEY ("manufacturer_id") REFERENCES "manufacturer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipment_model" ADD CONSTRAINT "equipment_model_ibfk_2" FOREIGN KEY ("category_id") REFERENCES "equipment_model_category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "part" ADD CONSTRAINT "part_ibfk_1" FOREIGN KEY ("manufacturer_id") REFERENCES "manufacturer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "part_service_price" ADD CONSTRAINT "part_service_price_ibfk_1" FOREIGN KEY ("part_id") REFERENCES "part"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "part_service_price" ADD CONSTRAINT "part_service_price_ibfk_2" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request" ADD CONSTRAINT "request_ibfk_1" FOREIGN KEY ("customer_id") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request" ADD CONSTRAINT "request_ibfk_2" FOREIGN KEY ("equipment_id") REFERENCES "equipment"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request" ADD CONSTRAINT "request_ibfk_3" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request" ADD CONSTRAINT "request_ibfk_4" FOREIGN KEY ("status_id") REFERENCES "request_status"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request_activity" ADD CONSTRAINT "request_activity_ibfk_1" FOREIGN KEY ("request_id") REFERENCES "request"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request_part" ADD CONSTRAINT "request_part_ibfk_1" FOREIGN KEY ("part_id") REFERENCES "part"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request_serviceman" ADD CONSTRAINT "request_serviceman_ibfk_2" FOREIGN KEY ("serviceman_id") REFERENCES "serviceman"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "request_status" ADD CONSTRAINT "request_status_ibfk_1" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "serviceman" ADD CONSTRAINT "serviceman_ibfk_1" FOREIGN KEY ("service_id") REFERENCES "service"("id") ON DELETE CASCADE ON UPDATE CASCADE;

