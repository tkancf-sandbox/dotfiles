import * as k from "karabiner_ts";

k.writeToProfile("karabiner.ts", [
  k.rule("長押し英数・かなをCommandキー、短押しで英数・かなにする").manipulators([
    k.withMapper(
      {
        "japanese_eisuu": "left_command",
        "japanese_kana": "right_command",
      } as const,
    )((cmd, lang) =>
    k.map({ key_code: cmd, modifiers: { optional: ["any"] } })
    .to({ key_code: cmd, lazy: true })
    .toIfAlone({ key_code: lang })
    .description(`Tap ${cmd} alone to switch to ${lang}`)
    .parameters({ "basic.to_if_held_down_threshold_milliseconds": 100 })
     ),
  ]),
  k.rule("バッククオートとチルダを割り当てる。").manipulators([
    k.map({ key_code: "international3", modifiers: { optional: ["any"] } })
    .to({ key_code: "grave_accent_and_tilde" })
    .type("basic"),
  ]),
  k.rule("コマンドキーをオプションキーに置き換える。").manipulators([
    k.map({ key_code: "left_command", modifiers: { optional: ["any"] } })
    .to({ key_code: "left_option" })
    .type("basic"),
  ]),
  k.rule("Post space is pressed alone, left_ctrl otherwise").manipulators([
    k.map({ key_code: "spacebar", modifiers: { optional: ["any"] } })
    .to({ key_code: "left_control" })
    .toIfAlone({ key_code: "spacebar" })
    .type("basic"),
  ]),

  k.rule("英数・かなキーを他のキーと組み合わせて押したときに、コマンドキーを送信する。").manipulators([
    k.map({ key_code: "japanese_eisuu", modifiers: { optional: ["any"] } })
      .to({ key_code: "left_command" })
      .toIfAlone({ key_code: "japanese_eisuu" })
      .type("basic"),
    k.map({ key_code: "japanese_kana", modifiers: { optional: ["any"] } })
      .to({ key_code: "right_command" })
      .toIfAlone({ key_code: "japanese_kana" })
      .type("basic"),
    k.map({ key_code: "right_command", modifiers: { optional: ["any"] } })
      .to({ key_code: "right_command" })
      .toIfAlone({ key_code: "japanese_kana" })
      .type("basic"),
  ]),

  k.rule("Swap Command & Ctrl+Alt in Discord").manipulators([
    k.map({ key_code: "left_command" })
      .to({ key_code: "left_option" })
      .conditions([
        {
          bundle_identifiers: ["com.github.wez.wezterm"],
          type: "frontmost_application_if",
        },
      ])
      .type("basic"),
  ]),
]);
