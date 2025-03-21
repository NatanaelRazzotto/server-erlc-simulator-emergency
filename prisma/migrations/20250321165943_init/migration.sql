-- CreateEnum
CREATE TYPE "UserType" AS ENUM ('FOUNDER', 'STAFF', 'PLAYER', 'DEVELOPER');

-- CreateEnum
CREATE TYPE "ReasonTowing" AS ENUM ('ILLEGAL_PARKING', 'TRAFFIC_VIOLATION', 'ABANDONED_VEHICLE', 'UNPAID_FINES', 'VEHICLE_SEIZURE', 'LACK_OF_DOCUMENTATION', 'BLOCKING_TRAFFIC', 'DRIVER_SUPPORT');

-- CreateEnum
CREATE TYPE "TrafficViolation" AS ENUM ('SPEEDING', 'STREET_RACING', 'RUNNING_RED_LIGHT', 'FAILURE_TO_OBEY_SIGNS', 'FAILURE_TO_YIELD_PEDESTRIANS', 'DRIVING_WITHOUT_LICENSE', 'EXPIRED_VEHICLE_REGISTRATION', 'DRIVING_WITHOUT_PLATES', 'DUI_DWI', 'TEXTING_WHILE_DRIVING', 'RECKLESS_DRIVING', 'ILLEGAL_PARKING', 'PARKING_DISABLED_SPOT', 'PARKING_FIRE_HYDRANT');

-- CreateEnum
CREATE TYPE "OperatingCategory" AS ENUM ('CARGA', 'PASSAGEIRO', 'ESPECIAL');

-- CreateEnum
CREATE TYPE "FuelType" AS ENUM ('DIESEL', 'GASOLINA', 'FLEX', 'ELETRICO');

-- CreateTable
CREATE TABLE "user" (
    "id" TEXT NOT NULL,
    "nickname" TEXT NOT NULL,
    "name_server" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "user_type" "UserType" NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "user_id" TEXT,

    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "natural_person" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "birth" TIMESTAMP(3) NOT NULL,
    "person_id" TEXT NOT NULL,

    CONSTRAINT "natural_person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicle" (
    "id" TEXT NOT NULL,
    "plate" TEXT,
    "serial_number" TEXT,
    "operating_category" "OperatingCategory" NOT NULL,
    "owner_id" TEXT,
    "bodywork_id" TEXT,

    CONSTRAINT "vehicle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicle_yard_registration" (
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "type_motivation" "ReasonTowing" NOT NULL,
    "request_authority" BOOLEAN NOT NULL DEFAULT false,
    "confiscated_vehicle" BOOLEAN NOT NULL DEFAULT true,
    "release_date" TIMESTAMP(3) NOT NULL DEFAULT (NOW() + INTERVAL '1 day'),
    "vehicle_Id" TEXT,
    "author_record_Id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "vehicle_yard_registration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "traffic_tickets" (
    "id" TEXT NOT NULL,
    "traffic_violation" "TrafficViolation" NOT NULL,
    "description_situation" TEXT NOT NULL,
    "coast" DOUBLE PRECISION NOT NULL DEFAULT 0.00,
    "payment_pending" BOOLEAN NOT NULL DEFAULT true,
    "vehicle_Id" TEXT,
    "author_record_Id" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "traffic_tickets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bodywork" (
    "id" TEXT NOT NULL,
    "name_model" TEXT NOT NULL,
    "description" TEXT,
    "serial_number" TEXT,
    "year" DOUBLE PRECISION NOT NULL,
    "manufacturer_id" TEXT,

    CONSTRAINT "bodywork_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "manufacturer" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "manufacturer_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "natural_person_cpf_key" ON "natural_person"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "natural_person_person_id_key" ON "natural_person"("person_id");

-- AddForeignKey
ALTER TABLE "person" ADD CONSTRAINT "person_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "natural_person" ADD CONSTRAINT "natural_person_person_id_fkey" FOREIGN KEY ("person_id") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle" ADD CONSTRAINT "vehicle_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "person"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle" ADD CONSTRAINT "vehicle_bodywork_id_fkey" FOREIGN KEY ("bodywork_id") REFERENCES "bodywork"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle_yard_registration" ADD CONSTRAINT "vehicle_yard_registration_vehicle_Id_fkey" FOREIGN KEY ("vehicle_Id") REFERENCES "vehicle"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "vehicle_yard_registration" ADD CONSTRAINT "vehicle_yard_registration_author_record_Id_fkey" FOREIGN KEY ("author_record_Id") REFERENCES "natural_person"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "traffic_tickets" ADD CONSTRAINT "traffic_tickets_vehicle_Id_fkey" FOREIGN KEY ("vehicle_Id") REFERENCES "vehicle"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "traffic_tickets" ADD CONSTRAINT "traffic_tickets_author_record_Id_fkey" FOREIGN KEY ("author_record_Id") REFERENCES "natural_person"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bodywork" ADD CONSTRAINT "bodywork_manufacturer_id_fkey" FOREIGN KEY ("manufacturer_id") REFERENCES "manufacturer"("id") ON DELETE SET NULL ON UPDATE CASCADE;
