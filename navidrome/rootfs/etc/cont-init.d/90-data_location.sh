#!/usr/bin/env bashio
# shellcheck shell=bash
# shellcheck disable=SC2155
set -e

# Configure app

bashio::config.has_value 'ND_ENABLESHARING' && export ND_ENABLESHARING=$(bashio::config 'ND_ENABLESHARING') && bashio::log.info "ND_ENABLESHARING set to $ND_ENABLESHARING"
bashio::config.has_value 'ND_MUSICFOLDER' && export ND_MUSICFOLDER=$(bashio::config 'ND_MUSICFOLDER') && bashio::log.info "ND_MUSICFOLDER set to $ND_MUSICFOLDER"
bashio::config.has_value 'ND_DATAFOLDER' && export ND_DATAFOLDER=$(bashio::config 'ND_DATAFOLDER') && bashio::log.info "ND_DATAFOLDER set to $ND_DATAFOLDER"

# Check data location
LOCATION=$(bashio::config 'ND_DATAFOLDER')
if !(bashio::config.has_value 'ND_DATAFOLDER'); then
    bashio::log.warning "No ND_DATAFOLDER location was provided."
    exit 1
fi

# Create folder
if [ ! -d "$ND_DATAFOLDER" ]; then
    bashio::log.info "Creating ND_DATAFOLDER $ND_DATAFOLDER"
    mkdir -p "$ND_DATAFOLDER"
fi

# export ND_BASEURL=/api/hassio_ingress/nzZbBSf89wBkxXceoWvFTtvazRHU2wLp0I7Oaf1RAyY

##############
# LAUNCH APP #
##############

## We are in the container's FS here
bashio::log.info "Looking inside /data"
ls -la /data

bashio::log.info "Looking inside /music"
ls -la /music

bashio::log.info "Looking inside ND_DATAFOLDER $ND_DATAFOLDER"
ls -la $ND_DATAFOLDER

bashio::log.info "Looking inside ND_MUSICFOLDER $ND_MUSICFOLDER"
ls -la $ND_MUSICFOLDER

bashio::log.info 'Starting Navidrome...'
/app/navidrome
