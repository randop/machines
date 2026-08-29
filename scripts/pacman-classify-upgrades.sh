#!/usr/bin/env bash
#
# pacman-classify-upgrades.sh
#
# Classifies pending pacman upgrades (from `pacman -Qu`) by version-bump
# type: MAJOR / MINOR / PATCH / REBUILD (pkgrel-only) / OTHER.
#
# Usage:
#   ./pacman-classify-upgrades.sh            # runs `pacman -Qu` itself
#   pacman -Qu | ./pacman-classify-upgrades.sh   # or pipe your own list in
#
# Note: run `sudo pacman -Sy` first (sync only, no upgrade) if you want
# this to reflect the latest available versions.

set -euo pipefail

# Colorize only when writing to a terminal
if [[ -t 1 ]]; then
    C_MAJOR=$'\033[1;31m'   # red
    C_MINOR=$'\033[1;33m'   # yellow
    C_PATCH=$'\033[1;32m'   # green
    C_REBUILD=$'\033[1;36m' # cyan
    C_OTHER=$'\033[1;35m'   # magenta
    C_RESET=$'\033[0m'
else
    C_MAJOR="" C_MINOR="" C_PATCH="" C_REBUILD="" C_OTHER="" C_RESET=""
fi

input_source() {
    if [[ -t 0 ]]; then
        pacman -Qu 2>/dev/null || true
    else
        cat
    fi
}

input_source | awk -v cMAJOR="$C_MAJOR" -v cMINOR="$C_MINOR" -v cPATCH="$C_PATCH" \
                    -v cREBUILD="$C_REBUILD" -v cOTHER="$C_OTHER" -v cRESET="$C_RESET" '
function strip_epoch(v) {
    sub(/^[0-9]+:/, "", v)
    return v
}
function strip_rel(v,    idx) {
    idx = match(v, /-[^-]+$/)
    if (idx > 0) return substr(v, 1, idx - 1)
    return v
}
function get_rel(v,    idx) {
    idx = match(v, /-[^-]+$/)
    if (idx > 0) return substr(v, idx + 1)
    return ""
}
function is_numeric(s) {
    return (s ~ /^[0-9]+$/)
}
function classify(oldfull, newfull,    ov, nv, orel, nrel, oa, na, n, m, maxn, i, o, nn, label) {
    ov   = strip_rel(strip_epoch(oldfull))
    nv   = strip_rel(strip_epoch(newfull))
    orel = get_rel(strip_epoch(oldfull))
    nrel = get_rel(strip_epoch(newfull))

    if (ov == nv) {
        if (orel != nrel) return "REBUILD"
        return "SAME"
    }

    n = split(ov, oa, ".")
    m = split(nv, na, ".")
    maxn = (n > m) ? n : m

    for (i = 1; i <= maxn; i++) {
        o  = (i in oa) ? oa[i] : "0"
        nn = (i in na) ? na[i] : "0"
        if (o == nn) continue
        if (is_numeric(o) && is_numeric(nn)) {
            if (i == 1) return "MAJOR"
            else if (i == 2) return "MINOR"
            else return "PATCH"
        } else {
            return "OTHER"
        }
    }
    return "PATCH"
}
BEGIN {
    printf "%-28s %-20s %-4s %-20s %s\n", "PACKAGE", "OLD VERSION", "", "NEW VERSION", "TYPE"
    printf "%-28s %-20s %-4s %-20s %s\n", "-------", "-----------", "", "-----------", "----"
    n_major = 0; n_minor = 0; n_patch = 0; n_rebuild = 0; n_other = 0
}
NF >= 4 {
    pkg   = $1
    oldv  = $2
    newv  = $4
    label = classify(oldv, newv)

    color = cRESET
    if (label == "MAJOR")   { color = cMAJOR;   n_major++ }
    else if (label == "MINOR")   { color = cMINOR;   n_minor++ }
    else if (label == "PATCH")   { color = cPATCH;   n_patch++ }
    else if (label == "REBUILD") { color = cREBUILD; n_rebuild++ }
    else if (label == "OTHER")   { color = cOTHER;   n_other++ }

    printf "%-28s %-20s %-4s %-20s %s%s%s\n", pkg, oldv, "->", newv, color, label, cRESET
    total++
}
END {
    if (total == 0) {
        print "No pending upgrades (or pacman -Qu produced no output)."
        exit 0
    }
    print "-------------------------------------------------------------------------"
    printf "Total: %d   %sMAJOR: %d%s   %sMINOR: %d%s   %sPATCH: %d%s   %sREBUILD: %d%s   %sOTHER: %d%s\n", \
        total, cMAJOR, n_major, cRESET, cMINOR, n_minor, cRESET, cPATCH, n_patch, cRESET, \
        cREBUILD, n_rebuild, cRESET, cOTHER, n_other, cRESET
}
'
