/// Presentational enums used exclusively by the UI component library.
///
/// These are purely visual — domain enums live in `/core/models/enums.dart`.

/// Visual variant for [TreeButton].
enum TreeButtonVariant { primary, secondary, danger }

/// Shape of a [TreeNode] marker.
enum TreeNodeShape { square, diamond }

/// Direction of a [TreeBranch] connector.
enum TreeBranchDirection { horizontal, vertical }

/// Display status for a [GameListItem].
enum GameItemStatus { yourTurn, waiting, won, lost, abandoned }
