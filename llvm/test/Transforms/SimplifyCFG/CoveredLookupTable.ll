; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -simplifycfg -switch-to-lookup -S %s | FileCheck %s
; RUN: opt -passes='simplify-cfg<switch-to-lookup>' -S %s | FileCheck %s
; rdar://15268442

target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin12.0.0"

define i3 @coveredswitch_test(i3 %input) {
; CHECK-LABEL: @coveredswitch_test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = icmp ult i3 [[INPUT:%.*]], -2
; CHECK-NEXT:    br i1 [[TMP0]], label [[SWITCH_LOOKUP:%.*]], label [[BB8:%.*]]
; CHECK:       switch.lookup:
; CHECK-NEXT:    [[SWITCH_CAST:%.*]] = zext i3 [[INPUT]] to i18
; CHECK-NEXT:    [[SWITCH_SHIFTAMT:%.*]] = mul i18 [[SWITCH_CAST]], 3
; CHECK-NEXT:    [[SWITCH_DOWNSHIFT:%.*]] = lshr i18 42792, [[SWITCH_SHIFTAMT]]
; CHECK-NEXT:    [[SWITCH_MASKED:%.*]] = trunc i18 [[SWITCH_DOWNSHIFT]] to i3
; CHECK-NEXT:    ret i3 [[SWITCH_MASKED]]
; CHECK:       bb8:
; CHECK-NEXT:    ret i3 -2
;
entry:
  switch i3 %input, label %bb8 [
  i3 0, label %bb7
  i3 1, label %bb
  i3 2, label %bb3
  i3 3, label %bb4
  i3 4, label %bb5
  i3 5, label %bb6
  ]

bb:                                               ; preds = %entry
  br label %bb8

bb3:                                              ; preds = %entry
  br label %bb8

bb4:                                              ; preds = %entry
  br label %bb8

bb5:                                              ; preds = %entry
  br label %bb8

bb6:                                              ; preds = %entry
  br label %bb8

bb7:                                              ; preds = %entry
  br label %bb8

bb8:                                              ; preds = %bb7, %bb6, %bb5, %bb4, %bb3, %bb, %entry
  %result = phi i3 [ 0, %bb7 ], [ 1, %bb6 ], [ 2, %bb5 ], [ 3, %bb4 ], [ 4, %bb3 ], [ 5, %bb ], [ 6, %entry ]
  ret i3 %result
}
