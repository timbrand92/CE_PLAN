# Cases that rely on a REMEMBERED CD value (pipe size), Wed 04 Nov 14:43, CE 02

1. **Answer:** 189 case files draw a pipe through the New Pipe window without typing the pipe size, so they use whatever size CD last remembered in CD_RecentValues.json. Only SETUP-R47v types it (fixed 4 Nov, size 225). The setups SETUP-P8, SETUP-P8v, SETUP-P8x2, SETUP-P8x2v and SETUP-R47 do not type it either.
2. **My mistake first:** at 07:17, 07:30 and 08:00 on 4 Nov (and 3 Nov 08:17) I put CD_RecentValues back from the file called RV_baseline_OLDEST_0111301_2772272A952C. That file was copied on 2 Nov at 20:27, AFTER the evening cases had left the size at 100. Before that the remembered size was 225. So my own restore planted 100 and every pack after 3 Nov 08:17, including the overnight smoke and the R16v87 reruns of 4 Nov, drew 100 mm pipes. CE 01's bisect is right. The overnight smoke PASS results are therefore on a 100 mm remembered size (they still passed).
3. **Fix made (4 Nov):** chain4.ps1 now keeps a copy of CD_RecentValues.json as found at chain start (C:\CE_WORK\scratch\RV_chainstart_*.json), writes its SHA-256 after every pack into the progress file, and puts the start copy back when AutoCAD has ended (a copy of the changed file is kept as RV_after_<pack>_*.json). I did not add the file to the driver's four-file fingerprint: cases that assert the four files unchanged would then fail whenever a pipe is drawn (the remembered values change legitimately). Backup: chain4.ps1.pre_rv_4nov.
4. **Do not use the 2 Nov baselines any more.** Restore only from the RV_chainstart copy of the same window.
5. **Full list** (case folder, case, why): C:\CE_WORK\scratch\remembered_size_cases_4nov.txt (copied below). Most are fine either way; the ones that assert a label with the size in it (225 DIA) matter. Retrofit order for the next case-writing pass: type the size in the setup (one line, as in SETUP-R47v) for SETUP-P8, P8v, P8x2, P8x2v, R47.

## List (folder, case, why)
. | N06_office_layers_current_layer_kept | setup SETUP-P8
. | N17_undo_names_tims_switches_cd_pit_move | setup SETUP-P8
. | N18_undo_names_switch_on_route_undo_then_pipe_u | own
. | N19_pit_catch_outline_plus_100 | own
. | N20_short_pipe_label_on_leader | own
. | N23_pit_catch_boundary_90_caught_110_free | own
. | N27_hand_placed_label_left_alone_by_tidy | setup SETUP-R47
. | N28_current_layer_kept_on_every_esc_path | own
. | N32_every_new_object_on_its_office_layer | own
. | R01_pit_cd_until_esc | setup SETUP-P8x2
. | R02_pipe_joins_pit | setup SETUP-P8
. | R02b_pipe_ends_on_pit | own
. | R03_one_il_text_each_end | setup SETUP-P8
. | R04_ce_never_saves | setup SETUP-P8
. | R11_edit_pipe_cascade_u_redo | setup SETUP-R47
. | R13_cdsync_warns_then_relinks | setup SETUP-R47
. | R14_cdtwl_freeboard_150 | setup SETUP-R47
. | R14h_both_200 | setup SETUP-R47
. | R14h_dstd_200 | setup SETUP-R47
. | R14h_pipekey_200 | setup SETUP-R47
. | R15_recover_inverts_totals | setup SETUP-R47
. | R16_tidy_labels_names_the_pipe | setup SETUP-R47
. | R17_cd_esc_at_third_point | own
. | R18_pipe_label_text_and_place | own
. | R19_erase_pit_keeps_pipes_u_restores | setup SETUP-R47
. | R24_metre_drawing_pit_size | own
. | R31_cd_uphill_levels_question_esc | own
. | R39_cd_existing_line_opens_new_pipe | own
. | R39b_cd_existing_arc_and_closed_line_kept | own
diag_c77_30oct | R01_pit_cd_until_esc_DA | setup SETUP-P8x2
diag_c77_30oct | R01_pit_cd_until_esc_DB | setup SETUP-P8x2
diag_c77_30oct | R14h_pipekey_200_DA | setup SETUP-R47
diag_c77_30oct | R14h_pipekey_200_DB | setup SETUP-R47
drafts_bug1227_30oct | N71_rotate_copy_onto_loose_pipe_end_joins | setup SETUP-R47
drafts_bug1227_30oct | N71_rotate_copy_onto_loose_pipe_end_joins_BROKEN | setup SETUP-R47
drafts_c78_30oct | N33_grade_mismatch_x_off | own
drafts_carpark_29oct | K01_typed_invert_kept_when_other_end_worked_out | own
drafts_carpark_29oct | K01_typed_invert_kept_when_other_end_worked_out_BROKEN | own
drafts_carpark_29oct | K02_one_level_label_has_no_min_suffix | own
drafts_carpark_29oct | K03_il_text_above_on_a_nearly_level_pipe | own
drafts_carpark_29oct | K03_il_text_above_on_a_nearly_level_pipe_BROKEN | own
drafts_carpark_29oct | K04_rotated_ucs_pit_after_cd_stays_square | own
drafts_carpark_29oct | K04_rotated_ucs_pit_after_cd_stays_square_BROKEN | own
drafts_carpark_29oct | K05_custom_grade_four_point_route | own
drafts_carpark_29oct | K05_custom_grade_four_point_route_BROKEN | own
drafts_carpark_29oct | K06_edit_pipe_moves_il_text_below | own
drafts_carpark_29oct | K06_edit_pipe_moves_il_text_below_BROKEN | own
drafts_carpark_30oct | K01_typed_invert_kept_when_other_end_worked_out | own
drafts_carpark_30oct | K01_typed_invert_kept_when_other_end_worked_out_BROKEN | own
drafts_carpark_30oct | K02_one_level_label_has_no_min_suffix | own
drafts_carpark_30oct | K03_il_text_above_on_a_nearly_level_pipe | own
drafts_carpark_30oct | K03_il_text_above_on_a_nearly_level_pipe_BROKEN | own
drafts_carpark_30oct | K04_rotated_ucs_pit_after_cd_stays_square | own
drafts_carpark_30oct | K04_rotated_ucs_pit_after_cd_stays_square_BROKEN | own
drafts_carpark_30oct | K05_custom_grade_four_point_route | own
drafts_carpark_30oct | K05_custom_grade_four_point_route_BROKEN | own
drafts_carpark_30oct | K06_edit_pipe_moves_il_text_below | own
drafts_carpark_30oct | K06_edit_pipe_moves_il_text_below_BROKEN | own
drafts_gap_30oct | N41_cdcheck_words_after_stretch_and_move | setup SETUP-R47
drafts_gap_30oct | N41_cdcheck_words_after_stretch_and_move_BROKEN | setup SETUP-R47
drafts_gap_30oct | N43_existing_layer_colours_never_changed | own
drafts_gap_30oct | N43_existing_layer_colours_never_changed_BROKEN | own
drafts_gap_30oct | N44_other_pipe_types_on_their_layers | own
drafts_gap_30oct | N44_other_pipe_types_on_their_layers_BROKEN | own
drafts_gap_30oct | N44v87_other_pipe_types_on_their_layers | own
drafts_gap_30oct | N44v87_other_pipe_types_on_their_layers_BROKEN | own
drafts_next40_a_30oct | N48_three_pipes_three_labels | own
drafts_next40_a_30oct | N48_three_pipes_three_labels_BROKEN | own
drafts_next40_a_30oct | N50_preview_then_apply_asks_nothing | setup SETUP-R47
drafts_next40_a_30oct | N50_preview_then_apply_asks_nothing_BROKEN | setup SETUP-R47
drafts_next40_a_30oct | N53_cd_from_dp_joins_downpipe | own
drafts_next40_a_30oct | N53_cd_from_dp_joins_downpipe_BROKEN | own
drafts_next40_b_30oct | N57_tidy_moves_only_ce_labels | setup SETUP-R47
drafts_next40_b_30oct | N57_tidy_moves_only_ce_labels_BROKEN | setup SETUP-R47
drafts_next40_b_30oct | N58_auto_join_74_caught_76_free | own
drafts_next40_b_30oct | N58_auto_join_74_caught_76_free_BROKEN | own
drafts_next40_b_30oct | N60_quiet_recheck_after_move | setup SETUP-P8
drafts_next40_b_30oct | N60_quiet_recheck_after_move_BROKEN | setup SETUP-P8
drafts_next40_b_30oct | N64_break_ce_pipe_then_u | setup SETUP-P8
drafts_next40_b_30oct | N64_break_ce_pipe_then_u_BROKEN | setup SETUP-P8
drafts_next40_b_30oct | N67_tidy_labels_apply_u | setup SETUP-R47
drafts_next40_b_30oct | N67_tidy_labels_apply_u_BROKEN | setup SETUP-R47
drafts_opus_27oct | N10_hide_grade_in_pipe_label | own
drafts_opus_27oct | N10_hide_grade_in_pipe_label_BROKEN | own
drafts_opus_28oct_b3 | N30_recent_invert_buttons_follow_last_pipe | own
drafts_opus_29oct_b4 | N31_hand_placed_text_kept_through_pit_move | setup SETUP-R47
drafts_opus_29oct_b4 | N31_hand_placed_text_kept_through_pit_move_BROKEN | setup SETUP-R47
drafts_opus_29oct_b4 | N32_every_new_object_on_its_office_layer | own
drafts_opus_29oct_b4 | N32_every_new_object_on_its_office_layer_BROKEN | setup SETUP-P8
drafts_opus_29oct_b5 | N35_hide_grade_through_more_options | own
drafts_opus_29oct_b5 | N35_hide_grade_through_more_options_BROKEN | own
drafts_pilot_29oct | P01_cdtextseg_label_goes_to_clicked_leg | own
drafts_pilot_29oct | P01_cdtextseg_label_goes_to_clicked_leg_BROKEN | own
drafts_probe_01nov | PROBE-CDSYNC-BA | own
drafts_probe_01nov | PROBE-CDSYNC-BA2 | own
drafts_probe_01nov | PROBE-DW2 | own
drafts_probe_01nov | PROBE-DW389 | own
drafts_probe_01nov | PROBE-FLAT4 | own
drafts_probe_01nov | PROBE-W234 | own
drafts_v387_30oct | GM1_broken | own
drafts_v387_30oct | GM1_flatter_than_1in100 | own
drafts_v387_30oct | GM1p_broken | own
drafts_v387_30oct | GM1p_pit_first_flatter | own
drafts_v387_30oct | GM2_broken | own
drafts_v387_30oct | GM2_steeper_asks_mismatch | own
drafts_v387_30oct | N06_brokenv87 | setup SETUP-P8v
drafts_v387_30oct | N06_office_layers_current_layer_keptv87 | setup SETUP-P8v
drafts_v387_30oct | N17_undo_names_tims_switches_cd_pit_movev87 | setup SETUP-P8v
drafts_v387_30oct | N18_brokenv87 | own
drafts_v387_30oct | N18_undo_names_switch_on_route_undo_then_pipe_uv87 | own
drafts_v387_30oct | N19_brokenv87 | own
drafts_v387_30oct | N19_pit_catch_outline_plus_100v87 | own
drafts_v387_30oct | N20_brokenv87 | own
drafts_v387_30oct | N20_short_pipe_label_on_leaderv87 | own
drafts_v387_30oct | N23_brokenv87 | own
drafts_v387_30oct | N23_pit_catch_boundary_90_caught_110_freev87 | own
drafts_v387_30oct | N28_current_layer_kept_on_every_esc_pathv87 | own
drafts_v387_30oct | R01_brokenv87 | setup SETUP-P8v
drafts_v387_30oct | R01_pit_cd_until_escv87 | setup SETUP-P8x2v
drafts_v387_30oct | R02_brokenv87 | own
drafts_v387_30oct | R02_pipe_joins_pitv87 | setup SETUP-P8v
drafts_v387_30oct | R02b_brokenv87 | own
drafts_v387_30oct | R02b_pipe_ends_on_pitv87 | own
drafts_v387_30oct | R03_brokenv87 | own
drafts_v387_30oct | R03_one_il_text_each_endv87 | setup SETUP-P8v
drafts_v387_30oct | R04_ce_never_savesv87 | setup SETUP-P8v
drafts_v387_30oct | R04_save_brokenv87 | setup SETUP-P8v
drafts_v387_30oct | R17_cd_esc_at_third_pointv87 | own
drafts_v387_30oct | R32_brokenv87 | own
drafts_v387_30oct | R39_cd_existing_line_opens_new_pipev87 | own
drafts_v387_30oct | R39_second_brokenv87 | own
drafts_v387_30oct | R39b_brokenv87 | own
drafts_v387_30oct | R39b_cd_existing_arc_and_closed_line_keptv87 | own
drafts_wave1_31oct | W223_BROKEN | own
drafts_wave1_31oct | W223_edit_pipe_open_ends_window_follows_levels | own
drafts_wave1_31oct | W234_BROKEN | own
drafts_wave1_31oct | W234_flat_pipe_moved_onto_other_pits | own
drafts_wave1_31oct | W244_BROKEN | own
drafts_wave1_31oct | W244_open_end_pipe_stays_downhill_after_move | own
drafts_wave1_31oct | W324_BROKEN | own
drafts_wave1_31oct | W324_batch_leaves_out_older_pipe | own
drafts_wave1_31oct | W325_BROKEN | own
drafts_wave1_31oct | W325_erase_pit_label_pipe_oops_one_line | own
drafts_wave1_31oct | W784_BROKEN | own
drafts_wave1_31oct | W784_from_column_keeps_c_pit_numbers | own
previous | R01_pit_cd_until_esc.v1_before_harden | setup SETUP-P8
previous | R02_pipe_joins_pit.v1_before_harden | setup SETUP-P8
previous | R02_pipe_joins_pit.v_before_b3fixes | setup SETUP-P8
previous | R03_one_il_text_each_end.v1_before_harden | setup SETUP-P8
previous | R04_ce_never_saves.v1_before_harden | setup SETUP-P8
previous | R04_ce_never_saves.v_before_b3fixes | setup SETUP-P8
previous | R04_ce_never_saves.v_before_b4fixes | setup SETUP-P8
previous | R04_save_broken.v_before_b4fixes | setup SETUP-P8
previous | R13_broken.v_before_b5fixes | setup SETUP-R47
previous | R13_cdsync_warns_then_relinks.v_before_b5fixes | setup SETUP-R47
previous | R14_broken.v_before_b5fixes | setup SETUP-R47
previous | R14_cdtwl_freeboard_150.v_before_b5fixes | setup SETUP-R47
previous | R14_dstd_broken.v_before_b5fixes | setup SETUP-R47
previous | R14_pipekey_broken.v_before_b5fixes | setup SETUP-R47
previous | R19_broken.v_before_b5fixes | setup SETUP-R47
previous | R19_erase_pit_keeps_pipes_u_restores.v_before_b5fixes | setup SETUP-R47
variants | N06_broken | setup SETUP-P8
variants | N18_broken | own
variants | N19_broken | own
variants | N20_broken | own
variants | N23_broken | own
variants | N27_broken | setup SETUP-R47
variants | N32_every_new_object_on_its_office_layer_BROKEN | setup SETUP-P8
variants | R01_broken | setup SETUP-P8
variants | R02_broken | own
variants | R02b_broken | own
variants | R03_broken | own
variants | R04_save_broken | setup SETUP-P8
variants | R11_broken | setup SETUP-R47
variants | R13_broken | setup SETUP-R47
variants | R13_rows_broken | setup SETUP-R47
variants | R14_broken | setup SETUP-R47
variants | R14_dstd_broken | setup SETUP-R47
variants | R14_pipekey_broken | setup SETUP-R47
variants | R15_broken | setup SETUP-R47
variants | R16_broken | setup SETUP-R47
variants | R16_off_broken | setup SETUP-R47
variants | R18_broken | setup SETUP-R47
variants | R19_broken | setup SETUP-R47
variants | R19_nou_broken | setup SETUP-R47
variants | R31_broken | own
variants | R32_broken | own
variants | R39_second_broken | own
variants | R39b_broken | own
