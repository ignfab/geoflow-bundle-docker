FROM scratch
ARG VERSION
LABEL org.opencontainers.image.authors="Balázs Dukai <balazs.dukai@3dgi.nl>"
LABEL org.opencontainers.image.vendor="3DGI"
LABEL org.opencontainers.image.title="lod22-reconstruct"
LABEL org.opencontainers.image.description="Tool for reconstructing building models"
LABEL org.opencontainers.image.licenses="(GPL-3.0 AND AGPL-3.0)"
LABEL org.opencontainers.image.version=$VERSION

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

COPY --from=ignfab/geoflow-bundle-builder:latest /export/ /
COPY flowcharts/gfc-brecon/stream/* /usr/local/geoflow-flowcharts/gfc-brecon/

ENTRYPOINT ["/usr/local/bin/geof", "/usr/local/geoflow-flowcharts/gfc-brecon/reconstruct.json"]
CMD ["--help"]