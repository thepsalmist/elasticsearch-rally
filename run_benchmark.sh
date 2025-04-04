#!/bin/bash

# Path variables
LOCAL_PATH=$(pwd)
ES_HOST="http://host.docker.internal:9200"
TRACK_NAME="mc-query-benchmark"
RACE_ID="mc_benchmark_$(date +%Y%m%d_%H%M%S)"
INDEX_NAME="mc_search_url-000001"

# Run the benchmark
docker run --rm --name esrally-benchmark \
  -v ${LOCAL_PATH}/tracks:/rally/.rally/tracks \
  -v ${LOCAL_PATH}/benchmarks:/rally/.rally/benchmarks \
  -v ${LOCAL_PATH}/logs:/rally/.rally/logs \
  elastic/rally race \
  --track-path=/rally/.rally/tracks/${TRACK_NAME} \
  --target-hosts=${ES_HOST} \
  --pipeline=benchmark-only \
  --report-format=csv \
  --report-file="/rally/.rally/benchmarks/${RACE_ID}.csv" \
  --on-error=abort

echo "Benchmark complete! Results saved to:"
echo "${LOCAL_PATH}/benchmarks/${RACE_ID}.csv"
