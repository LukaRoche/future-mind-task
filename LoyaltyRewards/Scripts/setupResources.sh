#!/bin/sh

SOURCE_PATH="${TARGET_NAME}/Resources"
TARGET_PATH="${TARGET_NAME}/Resources/Generated"

# Images
"${PODS_ROOT}/SwiftGen/bin/swiftgen" \
run xcassets "${SOURCE_PATH}/Images.xcassets" \
--templateName swift5 \
--output "${TARGET_PATH}/Images.swift"

# Colors
"${PODS_ROOT}/SwiftGen/bin/swiftgen" \
run xcassets "${SOURCE_PATH}/Colors.xcassets" \
--templatePath "${SOURCE_PATH}/swiftgenColorTemplate.stencil" \
--param enumName="AppColor" \
--output "${TARGET_PATH}/AppColor.swift"

# Strings
"${PODS_ROOT}/SwiftGen/bin/swiftgen" \
run strings "${SOURCE_PATH}/Localizable/en.lproj/Localizable.strings" \
--template structured-swift5 \
--param enumName="Localized" \
--output "${TARGET_PATH}/Localized.swift"
