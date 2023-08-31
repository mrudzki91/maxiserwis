-- AlterTable
ALTER TABLE "request_serviceman" ADD CONSTRAINT "request_serviceman_pkey" PRIMARY KEY ("request_id", "serviceman_id");

-- AddForeignKey
ALTER TABLE "request_serviceman" ADD CONSTRAINT "request_serviceman_request_id_fkey" FOREIGN KEY ("request_id") REFERENCES "request"("id") ON DELETE CASCADE ON UPDATE CASCADE;
