#!/bin/bash
echo $1
git am $1; git apply --reject $1; git add .; git am --resolved
