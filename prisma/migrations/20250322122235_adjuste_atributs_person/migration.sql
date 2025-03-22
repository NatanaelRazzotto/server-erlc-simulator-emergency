-- AlterTable
ALTER TABLE "vehicle_yard_registration" ALTER COLUMN "release_date" SET DEFAULT (NOW() + INTERVAL '1 day');

-- CreateIndex
CREATE INDEX "natural_person_cpf_idx" ON "natural_person"("cpf");
