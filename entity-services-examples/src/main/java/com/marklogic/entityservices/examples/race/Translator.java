package com.marklogic.entityservices.examples.race;

import com.marklogic.client.document.ServerTransform;
import com.marklogic.client.query.StructuredQueryBuilder;
import com.marklogic.client.query.StructuredQueryDefinition;
import com.marklogic.client.datamovement.ApplyTransformListener;
import com.marklogic.client.datamovement.JobTicket;
import com.marklogic.client.datamovement.QueryBatcher;
import com.marklogic.entityservices.examples.ExamplesBase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.TimeUnit;

public class Translator extends ExamplesBase {

    private static Logger logger = LoggerFactory.getLogger(Translator.class);

    public void translate() throws InterruptedException {
        StructuredQueryBuilder qb = new StructuredQueryBuilder();
        StructuredQueryDefinition qdef = qb.collection("race-envelopes");
        ServerTransform ingester = new ServerTransform("translator");
        ApplyTransformListener listener = new ApplyTransformListener().withTransform(ingester)
                .withApplyResult(ApplyTransformListener.ApplyResult.IGNORE).onSuccess(inPlaceBatch -> {
                    logger.debug("Batch transform SUCCESS");
                }).onBatchFailure((inPlaceBatch, throwable) -> {
                    // logger.warn("FAILURE on batch:" + inPlaceBatch.toString()
                    // + "\n", throwable);
                    // throwable.printStackTrace();
                    System.err.println(throwable.getMessage());
                    System.err.print(String.join("\n", inPlaceBatch.getItems()) + "\n");
                });

        QueryBatcher queryBatcher = moveMgr.newQueryBatcher(qdef).withBatchSize(100)
                .withThreadCount(5).onUrisReady(listener).onQueryFailure(exception -> {
                    logger.error("Query error");
                });

        JobTicket ticket = moveMgr.startJob(queryBatcher);
        queryBatcher.awaitTermination(Long.MAX_VALUE, TimeUnit.DAYS);
        moveMgr.stopJob(ticket);
    }
}
