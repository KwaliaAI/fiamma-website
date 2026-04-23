import { useEffect, useState } from 'react'

type CountEntry = {
  count: number
  estimated?: boolean
}

type TrackedTell = {
  id: string
  label: string
}

type PassProfile = {
  id: string
  label: string
  kind: string
  counts: Record<string, number | null>
}

type ScorecardGroup = {
  founder5: Record<string, number | null>
  humanity: Record<string, number | null>
  relationship: Record<string, number | null>
  pressure: Record<string, number | null>
}

type RubricPass = {
  id: string
  label: string
  scope: string
  metrics: {
    target_words: number | null
    claimed_words: number | null
    actual_words: number | null
    total_tells: number | null
  }
  tell_counts: Record<string, number | null>
  scorecards: ScorecardGroup
}

type TitleMetrics = {
  id: string
  run_id: string
  title: string
  author: string
  source_author_label?: string
  model: {
    id: string
    alias: string
  }
  genre: string
  genre_detail: string
  target_words: number
  actual_words: number
  chapters: number
  tells_per_chapter: number
  shared_category_total: number
  full_spectrum_total: number
  severity: {
    high: number
    medium: number
    low: number
  }
  shared_category_counts: Record<string, CountEntry>
  tell_counts: Record<string, number>
  editorial_distance: {
    basis: string
    raw: number
    after_high: number
    after_medium: number
    after_low: number
    publishable: number
  }
  worst_chapters: Array<{
    label: string
    count: number
  }>
  production: {
    batches: number | null
    tokens_consumed: number | null
    time_to_completion_hours: number | null
    word_count_fabrication_events: Array<{
      label: string
      claimed: number
      actual: number
      fabrication_pct: number
    }>
    rewrite_from_memory_events: Array<{
      label: string
      before: number
      after: number
      loss: number
      loss_pct: number
    }>
  }
  passes: RubricPass[]
  editorial_catch: {
    gm_caught: number | null
    founder_caught: number | null
    founder_interventions: string[]
  }
  pass_profiles: PassProfile[]
  karen2: {
    relative_quality_score: number | null
    anchor: string | null
  }
}

type DashboardData = {
  meta: {
    title: string
    generated_at: string
    goal_tells_per_chapter: number
    tracked_tells: TrackedTell[]
    notes: string[]
    karen2: {
      enabled: boolean
      slot_ready: boolean
      metric_key: string
      ceiling_anchor: string | null
    }
  }
  titles: TitleMetrics[]
  model_registry: Array<{
    model_id: string
    alias: string
    titles_written: string[]
    genre: string
    avg_tells_per_chapter: number
    best_at: string
    worst_at: string
  }>
  genre_matrix: Array<{
    genre: string
    detail: string
    model: string
    title: string
    tells_per_chapter: number | null
    key_tells: string
    notes: string
  }>
  migration: Array<{
    drive: string
    opus3: string
    opus46: string
    predicted_next: string
  }>
}

const categoryLabels: Record<string, string> = {
  em_dashes: 'Em dashes',
  over_explanation: 'Over-explanation',
  staccato_triads: 'Staccato triads',
  performed_insight: 'Performed insight',
  empty_intensifiers: 'Empty intensifiers',
  vocabulary_elevation: 'Vocabulary elevation',
  hedges: 'Hedges',
  gravity_of_cliche: 'Gravity of cliche',
  not_x_reframing: 'Not X reframing',
  consciousness_markers: 'Consciousness markers',
  metacommentary: 'Metacommentary',
  negation_beats: 'Negation beats',
  the_way_pattern: 'The way pattern',
  philosophical_character_shape: 'Philosophical character shape',
  kind_of: 'Kind of',
  particular: 'The particular',
  phrase_repetition_patterns: 'Phrase repetition',
  balanced_paragraphs: 'Balanced paragraphs',
  artificial_balance: 'Artificial balance',
}

const categoryColors: Record<string, string> = {
  em_dashes: '#f28b82',
  over_explanation: '#d56a6a',
  staccato_triads: '#b85a50',
  performed_insight: '#8d4a43',
  empty_intensifiers: '#f4b49a',
  vocabulary_elevation: '#d9a679',
  hedges: '#bfb0a3',
  gravity_of_cliche: '#8c8c8c',
  not_x_reframing: '#f8a978',
  consciousness_markers: '#d97b66',
  metacommentary: '#ab5f66',
  negation_beats: '#7f4a57',
  the_way_pattern: '#6b7280',
  philosophical_character_shape: '#4b5563',
  kind_of: '#e9c46a',
  particular: '#c08457',
  phrase_repetition_patterns: '#99627a',
  balanced_paragraphs: '#8f95d3',
  artificial_balance: '#7a7a9d',
}

const sharedComparisonKeys = [
  'em_dashes',
  'over_explanation',
  'staccato_triads',
  'performed_insight',
  'empty_intensifiers',
  'vocabulary_elevation',
  'hedges',
  'gravity_of_cliche',
]

const passPalette = ['#d56a6a', '#f28b82', '#c08457', '#7f4a57', '#4b5563', '#99627a']

const scoreGroups = [
  {
    id: 'founder5',
    label: "Founder's 5",
    metrics: [
      { id: 'fun', label: 'Fun' },
      { id: 'hot', label: 'Hot' },
      { id: 'stakes_low_point', label: 'Stakes + low' },
      { id: 'physical_fun', label: 'Physical fun' },
      { id: 'romantic', label: 'Romantic' },
    ],
  },
  {
    id: 'humanity',
    label: 'Humanity Beats',
    metrics: [
      { id: 'wrong_analysis', label: 'Wrong analysis' },
      { id: 'ugly_moment', label: 'Ugly moment' },
      { id: 'uncontrolled_moment', label: 'Uncontrolled' },
      { id: 'lens_disengages', label: 'Lens off' },
      { id: 'coping_mechanism_breaks', label: 'Coping breaks' },
    ],
  },
  {
    id: 'relationship',
    label: 'Relationship',
    metrics: [
      { id: 'love_interest_5sentence', label: '5-sentence test' },
      { id: 'love_interest_mundane_details', label: 'Mundane details' },
      { id: 'supporting_char_flaws', label: 'Supporting flaws' },
      { id: 'mundane_moments', label: 'Mundane scenes' },
      { id: 'plain_language_love', label: 'Plain-language love' },
    ],
  },
  {
    id: 'pressure',
    label: 'Pressure + Scene Craft',
    metrics: [
      { id: 'low_point_sits', label: 'Low point sits' },
      { id: 'financial_distress_physical', label: 'Debt body count' },
      { id: 'sex_count', label: 'Sex scenes' },
      { id: 'sex_voice_breaks', label: 'Sex voice breaks' },
      { id: 'fun_scene', label: 'Fun scene' },
    ],
  },
] as const

function formatNumber(value: number | null) {
  if (value === null) return 'Not tracked'
  return new Intl.NumberFormat('en-GB').format(value)
}

function formatMetric(value: number | null) {
  if (value === null) return 'Not tracked'
  if (Number.isInteger(value)) return String(value)
  return value.toFixed(1)
}

function formatPct(value: number) {
  return `${value.toFixed(1)}%`
}

function categoryLabel(key: string) {
  return categoryLabels[key] ?? key.replace(/_/g, ' ')
}

function countForCategory(title: TitleMetrics, key: string) {
  return title.tell_counts[key] ?? title.shared_category_counts[key]?.count ?? 0
}

function passProfileTotal(profile: PassProfile, tellIds: string[]) {
  return tellIds.reduce((sum, tellId) => {
    const value = profile.counts[tellId]
    return typeof value === 'number' ? sum + value : sum
  }, 0)
}

function aggregateModelPassProfiles(titles: TitleMetrics[], modelId: string, tellIds: string[]) {
  const grouped = new Map<
    string,
    {
      id: string
      label: string
      kind: string
      titleIds: Set<string>
      totals: Record<string, number>
      counts: Record<string, number>
    }
  >()
  const order: string[] = []

  for (const title of titles) {
    if (title.model.id !== modelId) continue

    for (const profile of title.pass_profiles) {
      if (!grouped.has(profile.id)) {
        grouped.set(profile.id, {
          id: profile.id,
          label: profile.label,
          kind: profile.kind,
          titleIds: new Set<string>(),
          totals: {},
          counts: {},
        })
        order.push(profile.id)
      }

      const bucket = grouped.get(profile.id)
      if (!bucket) continue
      bucket.titleIds.add(title.id)

      for (const tellId of tellIds) {
        const value = profile.counts[tellId]
        if (typeof value !== 'number') continue
        bucket.totals[tellId] = (bucket.totals[tellId] ?? 0) + value
        bucket.counts[tellId] = (bucket.counts[tellId] ?? 0) + 1
      }
    }
  }

  return order.map((profileId) => {
    const bucket = grouped.get(profileId)
    if (!bucket) {
      return {
        id: profileId,
        label: profileId,
        kind: 'observed',
        counts: {},
        title_count: 0,
      }
    }

    return {
      id: bucket.id,
      label: bucket.label,
      kind: bucket.kind,
      title_count: bucket.titleIds.size,
      counts: Object.fromEntries(
        tellIds.map((tellId) => {
          const sampleCount = bucket.counts[tellId] ?? 0
          if (sampleCount === 0) return [tellId, null]
          const average = bucket.totals[tellId] / sampleCount
          return [tellId, Math.round(average * 10) / 10]
        }),
      ),
    }
  })
}

function averageNumeric(values: Array<number | null>) {
  const filtered = values.filter((value): value is number => typeof value === 'number')
  if (filtered.length === 0) return null
  const average = filtered.reduce((sum, value) => sum + value, 0) / filtered.length
  return Math.round(average * 10) / 10
}

function sumNumeric(values: Array<number | null>) {
  const filtered = values.filter((value): value is number => typeof value === 'number')
  if (filtered.length === 0) return null
  return filtered.reduce((sum, value) => sum + value, 0)
}

function calculateDelta(start: number | null, end: number | null) {
  if (start === null || end === null) return null
  return Math.round((end - start) * 10) / 10
}

function formatSignedDelta(value: number | null) {
  if (value === null) return '—'
  if (value === 0) return '0'
  return `${value > 0 ? '+' : ''}${formatMetric(value)}`
}

function aggregateEditorialCatch(titles: TitleMetrics[], modelId: string) {
  const scopedTitles = titles.filter((title) => title.model.id === modelId)
  return {
    gm_caught: sumNumeric(scopedTitles.map((title) => title.editorial_catch.gm_caught)),
    founder_caught: sumNumeric(scopedTitles.map((title) => title.editorial_catch.founder_caught)),
    founder_interventions: [...new Set(scopedTitles.flatMap((title) => title.editorial_catch.founder_interventions))],
  }
}

function titleTellCoverage(title: TitleMetrics, tellIds: string[]) {
  return title.passes.reduce(
    (sum, pass) =>
      sum +
      tellIds.filter((tellId) => typeof pass.tell_counts[tellId] === 'number').length,
    0,
  )
}

function modelTellCoverage(titles: TitleMetrics[], modelId: string, tellIds: string[]) {
  return titles
    .filter((title) => title.model.id === modelId)
    .reduce((sum, title) => sum + titleTellCoverage(title, tellIds), 0)
}

function aggregateModelPasses(titles: TitleMetrics[], modelId: string, tellIds: string[]) {
  const grouped = new Map<
    string,
    {
      id: string
      label: string
      scope: string
      metrics: Record<string, Array<number | null>>
      tellCounts: Record<string, Array<number | null>>
      scorecards: Record<string, Record<string, Array<number | null>>>
    }
  >()
  const order: string[] = []

  for (const title of titles) {
    if (title.model.id !== modelId) continue

    for (const pass of title.passes) {
      if (!grouped.has(pass.id)) {
        grouped.set(pass.id, {
          id: pass.id,
          label: pass.label,
          scope: pass.scope,
          metrics: {
            target_words: [],
            claimed_words: [],
            actual_words: [],
            total_tells: [],
          },
          tellCounts: Object.fromEntries(tellIds.map((tellId) => [tellId, []])),
          scorecards: Object.fromEntries(
            scoreGroups.map((group) => [
              group.id,
              Object.fromEntries(group.metrics.map((metric) => [metric.id, []])),
            ]),
          ),
        })
        order.push(pass.id)
      }

      const bucket = grouped.get(pass.id)
      if (!bucket) continue

      bucket.metrics.target_words.push(pass.metrics.target_words)
      bucket.metrics.claimed_words.push(pass.metrics.claimed_words)
      bucket.metrics.actual_words.push(pass.metrics.actual_words)
      bucket.metrics.total_tells.push(pass.metrics.total_tells)

      for (const tellId of tellIds) {
        bucket.tellCounts[tellId].push(pass.tell_counts[tellId] ?? null)
      }

      for (const group of scoreGroups) {
        for (const metric of group.metrics) {
          bucket.scorecards[group.id][metric.id].push(pass.scorecards[group.id][metric.id] ?? null)
        }
      }
    }
  }

  return order.map((passId) => {
    const bucket = grouped.get(passId)
    if (!bucket) {
      return {
        id: passId,
        label: passId,
        scope: 'missing',
        metrics: {
          target_words: null,
          claimed_words: null,
          actual_words: null,
          total_tells: null,
        },
        tell_counts: Object.fromEntries(tellIds.map((tellId) => [tellId, null])),
        scorecards: {
          founder5: {},
          humanity: {},
          relationship: {},
          pressure: {},
        } as ScorecardGroup,
      }
    }

    return {
      id: bucket.id,
      label: bucket.label,
      scope: bucket.scope,
      metrics: {
        target_words: averageNumeric(bucket.metrics.target_words),
        claimed_words: averageNumeric(bucket.metrics.claimed_words),
        actual_words: averageNumeric(bucket.metrics.actual_words),
        total_tells: averageNumeric(bucket.metrics.total_tells),
      },
      tell_counts: Object.fromEntries(
        tellIds.map((tellId) => [tellId, averageNumeric(bucket.tellCounts[tellId])]),
      ),
      scorecards: Object.fromEntries(
        scoreGroups.map((group) => [
          group.id,
          Object.fromEntries(
            group.metrics.map((metric) => [
              metric.id,
              averageNumeric(bucket.scorecards[group.id][metric.id]),
            ]),
          ),
        ]),
      ) as ScorecardGroup,
    }
  })
}

function SectionHeading({
  eyebrow,
  title,
  description,
}: {
  eyebrow: string
  title: string
  description: string
}) {
  return (
    <div className="mb-8">
      <p className="mb-2 text-sm font-semibold uppercase tracking-[0.22em] text-fiamma-coral">{eyebrow}</p>
      <h2 className="mb-3 text-3xl font-bold text-fiamma-text md:text-4xl">{title}</h2>
      <p className="max-w-3xl text-base leading-7 text-gray-600 md:text-lg">{description}</p>
    </div>
  )
}

function StatCard({ label, value, note }: { label: string; value: string; note: string }) {
  return (
    <div className="rounded-[2rem] border border-white/80 bg-white/90 p-6 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <p className="text-sm font-semibold uppercase tracking-[0.18em] text-gray-500">{label}</p>
      <p className="mt-4 font-display text-4xl text-fiamma-text">{value}</p>
      <p className="mt-3 text-sm leading-6 text-gray-600">{note}</p>
    </div>
  )
}

function buildSeriesPath(points: Array<{ x: number; y: number; value: number | null }>) {
  let path = ''
  let drawing = false

  for (const point of points) {
    if (point.value === null) {
      drawing = false
      continue
    }

    path += `${drawing ? ' L' : 'M'} ${point.x.toFixed(2)} ${point.y.toFixed(2)}`
    drawing = true
  }

  return path.trim()
}

function PassProfileChart({
  titles,
  trackedTells,
}: {
  titles: TitleMetrics[]
  trackedTells: TrackedTell[]
}) {
  const modelOptions = [...new Map(titles.map((title) => [title.model.id, title.model])).values()].sort((left, right) =>
    left.alias.localeCompare(right.alias),
  )
  const titleOptions = [...titles].sort((left, right) => left.run_id.localeCompare(right.run_id))
  const tellIds = trackedTells.map((tell) => tell.id)

  const defaultModelId =
    [...titles]
      .sort((left, right) => right.pass_profiles.length - left.pass_profiles.length)
      .at(0)?.model.id ?? modelOptions[0]?.id ?? ''
  const defaultTitleId =
    [...titles]
      .sort((left, right) => right.pass_profiles.length - left.pass_profiles.length)
      .at(0)?.id ?? titleOptions[0]?.id ?? ''

  const [viewMode, setViewMode] = useState<'model' | 'title'>('model')
  const [selectedModelId, setSelectedModelId] = useState(defaultModelId)
  const [selectedTitleId, setSelectedTitleId] = useState(defaultTitleId)

  const activeModelId = modelOptions.some((model) => model.id === selectedModelId) ? selectedModelId : defaultModelId
  const activeTitleId = titleOptions.some((title) => title.id === selectedTitleId) ? selectedTitleId : defaultTitleId

  const activeTitle = titles.find((title) => title.id === activeTitleId) ?? titleOptions[0]
  const activeModel = modelOptions.find((model) => model.id === activeModelId) ?? modelOptions[0]
  const activeTitlesForModel = titles.filter((title) => title.model.id === activeModel?.id)
  const series =
    viewMode === 'model'
      ? aggregateModelPassProfiles(titles, activeModel?.id ?? '', tellIds)
      : activeTitle?.pass_profiles ?? []
  const visibleSeries = series.filter((profile) =>
    tellIds.some((tellId) => typeof profile.counts[tellId] === 'number'),
  )
  const maxValue = Math.max(
    1,
    ...visibleSeries.flatMap((profile) =>
      tellIds
        .map((tellId) => profile.counts[tellId])
        .filter((value): value is number => typeof value === 'number'),
    ),
  )
  const yMax = maxValue <= 12 ? Math.ceil(maxValue) : Math.ceil(maxValue / 5) * 5
  const width = 1180
  const height = 520
  const paddingLeft = 72
  const paddingRight = 28
  const paddingTop = 32
  const paddingBottom = 170
  const usableWidth = width - paddingLeft - paddingRight
  const usableHeight = height - paddingTop - paddingBottom
  const xStep = trackedTells.length > 1 ? usableWidth / (trackedTells.length - 1) : usableWidth / 2
  const gridLines = 5
  const scopeLabel =
    viewMode === 'model'
      ? `${activeModel?.alias ?? 'Model'} averaged across ${activeTitlesForModel.length} title${activeTitlesForModel.length === 1 ? '' : 's'}`
      : `${activeTitle?.run_id ?? 'Title'} recorded pass history`

  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-6 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <div className="mb-6 flex flex-col gap-6 xl:flex-row xl:items-start xl:justify-between">
        <div>
          <h3 className="text-xl font-semibold text-fiamma-text">AI tell trajectory by pass</h3>
          <p className="mt-2 max-w-2xl text-sm leading-6 text-gray-600">
            Every tracked tell sits on one axis. Each line is a recorded pass, so you can see where the count actually fell and where no rescans were logged.
          </p>
        </div>
        <div className="flex flex-col gap-3 sm:flex-row">
          <div className="rounded-[1.5rem] bg-fiamma-bg p-1">
            {(['model', 'title'] as const).map((option) => (
              <button
                key={option}
                type="button"
                className={`rounded-[1.1rem] px-4 py-2 text-sm font-medium transition ${
                  viewMode === option ? 'bg-white text-fiamma-text shadow-sm' : 'text-gray-500'
                }`}
                onClick={() => setViewMode(option)}
              >
                {option === 'model' ? 'By model' : 'By title'}
              </button>
            ))}
          </div>
          <select
            className="rounded-[1.2rem] border border-[#f1ddd7] bg-white px-4 py-3 text-sm text-fiamma-text outline-none"
            value={viewMode === 'model' ? activeModel?.id ?? '' : activeTitle?.id ?? ''}
            onChange={(event) => {
              if (viewMode === 'model') {
                setSelectedModelId(event.target.value)
              } else {
                setSelectedTitleId(event.target.value)
              }
            }}
          >
            {(viewMode === 'model' ? modelOptions : titleOptions).map((option) => (
              <option key={option.id} value={option.id}>
                {'alias' in option ? option.alias : `${option.run_id} - ${option.title}`}
              </option>
            ))}
          </select>
        </div>
      </div>

      <div className="mb-6 grid gap-4 md:grid-cols-3">
        <StatCard
          label="Tracked Tells"
          value={String(trackedTells.length)}
          note="Every tell on the x-axis is plotted in the same order for every title and model."
        />
        <StatCard
          label="Recorded Passes"
          value={String(visibleSeries.length)}
          note={scopeLabel}
        />
        <StatCard
          label="Current Scope"
          value={viewMode === 'model' ? activeModel?.alias ?? 'Model' : activeTitle?.run_id ?? 'Title'}
          note="Gaps in a line mean that tell was not rescanned after that pass."
        />
      </div>

      <svg viewBox={`0 0 ${width} ${height}`} className="h-auto w-full">
        {Array.from({ length: gridLines + 1 }, (_, index) => {
          const value = (yMax / gridLines) * index
          const y = paddingTop + usableHeight - (value / yMax) * usableHeight

          return (
            <g key={value}>
              <line x1={paddingLeft} y1={y} x2={width - paddingRight} y2={y} stroke="#f5e6e1" strokeWidth="1" />
              <text x={paddingLeft - 12} y={y + 4} textAnchor="end" className="fill-gray-500 text-[11px] font-medium">
                {formatMetric(value)}
              </text>
            </g>
          )
        })}

        {trackedTells.map((tell, index) => {
          const x = paddingLeft + xStep * index

          return (
            <g key={tell.id}>
              <line x1={x} y1={paddingTop} x2={x} y2={paddingTop + usableHeight} stroke="#faf0ec" strokeWidth="1" />
              <g transform={`translate(${x}, ${height - paddingBottom + 24}) rotate(34)`}>
                <text textAnchor="start" className="fill-gray-600 text-[11px] font-medium">
                  {tell.label}
                </text>
              </g>
            </g>
          )
        })}

        {visibleSeries.map((profile, seriesIndex) => {
          const points = trackedTells.map((tell, tellIndex) => {
            const value = profile.counts[tell.id]
            const x = paddingLeft + xStep * tellIndex
            const y =
              value === null
                ? paddingTop + usableHeight
                : paddingTop + usableHeight - (value / yMax) * usableHeight
            return { x, y, value }
          })

          return (
            <g key={profile.id}>
              <path
                d={buildSeriesPath(points)}
                fill="none"
                stroke={passPalette[seriesIndex % passPalette.length]}
                strokeWidth="4"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              {points
                .filter((point) => point.value !== null)
                .map((point) => (
                  <circle
                    key={`${profile.id}-${point.x}`}
                    cx={point.x}
                    cy={point.y}
                    r="4.5"
                    fill="#fffaf8"
                    stroke={passPalette[seriesIndex % passPalette.length]}
                    strokeWidth="3"
                  />
                ))}
            </g>
          )
        })}
      </svg>

      <div className="mt-6 grid gap-3 md:grid-cols-2 xl:grid-cols-4">
        {visibleSeries.map((profile, index) => (
          <div key={profile.id} className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
            <div className="flex items-center gap-3">
              <span
                className="block h-[3px] w-8 rounded-full"
                style={{ backgroundColor: passPalette[index % passPalette.length] }}
              />
              <p className="text-sm font-semibold text-fiamma-text">{profile.label}</p>
            </div>
            <p className="mt-3 text-2xl font-semibold text-fiamma-text">
              {formatMetric(passProfileTotal(profile, tellIds))}
            </p>
            <p className="mt-2 text-sm leading-6 text-gray-600">
              Total recorded tell hits in this pass across the tracked set.
            </p>
          </div>
        ))}
      </div>
    </div>
  )
}

function PanelHeader({ title, note }: { title: string; note?: string }) {
  return (
    <div className="mb-4 flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
      <h2 className="text-lg font-semibold text-fiamma-text">{title}</h2>
      {note ? <p className="text-xs uppercase tracking-[0.16em] text-gray-500">{note}</p> : null}
    </div>
  )
}

function DashboardControls({
  viewMode,
  onViewModeChange,
  selectedId,
  onSelectedIdChange,
  modelOptions,
  titleOptions,
}: {
  viewMode: 'model' | 'title'
  onViewModeChange: (mode: 'model' | 'title') => void
  selectedId: string
  onSelectedIdChange: (value: string) => void
  modelOptions: Array<{ id: string; alias: string }>
  titleOptions: TitleMetrics[]
}) {
  return (
    <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
      <div className="rounded-[1.4rem] bg-fiamma-bg p-1">
        {(['model', 'title'] as const).map((option) => (
          <button
            key={option}
            type="button"
            className={`rounded-[1rem] px-4 py-2 text-sm font-medium transition ${
              viewMode === option ? 'bg-white text-fiamma-text shadow-sm' : 'text-gray-500'
            }`}
            onClick={() => onViewModeChange(option)}
          >
            {option === 'model' ? 'By model' : 'By title'}
          </button>
        ))}
      </div>
      <select
        className="rounded-[1.1rem] border border-[#f1ddd7] bg-white px-4 py-3 text-sm text-fiamma-text outline-none"
        value={selectedId}
        onChange={(event) => onSelectedIdChange(event.target.value)}
      >
        {(viewMode === 'model' ? modelOptions : titleOptions).map((option) => (
          <option key={option.id} value={option.id}>
            {'alias' in option ? option.alias : `${option.run_id} - ${option.title}`}
          </option>
        ))}
      </select>
    </div>
  )
}

function PassStrip({ passes }: { passes: RubricPass[] }) {
  return (
    <div className="grid gap-3 md:grid-cols-2 xl:grid-cols-4">
      {passes.map((pass) => (
        <div key={pass.id} className="rounded-[1.5rem] border border-white/80 bg-white p-4 shadow-[0_18px_60px_rgba(242,139,130,0.08)]">
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-fiamma-coral">{pass.label}</p>
          <p className="mt-2 text-xs leading-5 text-gray-500">{pass.scope}</p>
          <div className="mt-4 grid gap-3 sm:grid-cols-2">
            <div>
              <p className="text-[11px] uppercase tracking-[0.14em] text-gray-400">Words</p>
              <p className="mt-1 text-lg font-semibold text-fiamma-text">{formatMetric(pass.metrics.actual_words)}</p>
            </div>
            <div>
              <p className="text-[11px] uppercase tracking-[0.14em] text-gray-400">Tells</p>
              <p className="mt-1 text-lg font-semibold text-fiamma-text">{formatMetric(pass.metrics.total_tells)}</p>
            </div>
          </div>
        </div>
      ))}
    </div>
  )
}

function MiniLineChart({
  title,
  passes,
  series,
}: {
  title: string
  passes: RubricPass[]
  series: Array<{ id: string; label: string; color: string; values: Array<number | null> }>
}) {
  const width = 520
  const height = 220
  const paddingLeft = 44
  const paddingRight = 20
  const paddingTop = 16
  const paddingBottom = 58
  const usableWidth = width - paddingLeft - paddingRight
  const usableHeight = height - paddingTop - paddingBottom
  const allValues = series.flatMap((entry) => entry.values.filter((value): value is number => typeof value === 'number'))
  const maxValue = Math.max(1, ...allValues)
  const yMax = maxValue <= 12 ? Math.ceil(maxValue) : Math.ceil(maxValue / 5) * 5
  const xStep = passes.length > 1 ? usableWidth / (passes.length - 1) : usableWidth / 2

  return (
    <div className="rounded-[1.6rem] bg-[#fff8f5] p-4">
      <div className="mb-3 flex items-center justify-between gap-4">
        <p className="text-sm font-semibold text-fiamma-text">{title}</p>
        <div className="flex flex-wrap items-center gap-3">
          {series.map((entry) => (
            <div key={entry.id} className="flex items-center gap-2 text-xs text-gray-500">
              <span className="h-[3px] w-6 rounded-full" style={{ backgroundColor: entry.color }} />
              <span>{entry.label}</span>
            </div>
          ))}
        </div>
      </div>
      <svg viewBox={`0 0 ${width} ${height}`} className="h-auto w-full">
        {Array.from({ length: 5 }, (_, index) => {
          const value = (yMax / 4) * index
          const y = paddingTop + usableHeight - (value / yMax) * usableHeight
          return (
            <g key={value}>
              <line x1={paddingLeft} y1={y} x2={width - paddingRight} y2={y} stroke="#f1ddd7" strokeWidth="1" />
              <text x={paddingLeft - 8} y={y + 4} textAnchor="end" className="fill-gray-500 text-[10px] font-medium">
                {formatMetric(value)}
              </text>
            </g>
          )
        })}

        {passes.map((pass, index) => {
          const x = paddingLeft + xStep * index
          return (
            <g key={pass.id}>
              <line x1={x} y1={paddingTop} x2={x} y2={paddingTop + usableHeight} stroke="#f8ebe6" strokeWidth="1" />
              <g transform={`translate(${x}, ${height - paddingBottom + 18}) rotate(28)`}>
                <text textAnchor="start" className="fill-gray-500 text-[10px] font-medium">
                  {pass.label}
                </text>
              </g>
            </g>
          )
        })}

        {series.map((entry) => {
          const points = entry.values.map((value, index) => {
            const x = paddingLeft + xStep * index
            const y =
              value === null
                ? paddingTop + usableHeight
                : paddingTop + usableHeight - (value / yMax) * usableHeight
            return { x, y, value }
          })

          return (
            <g key={entry.id}>
              <path
                d={buildSeriesPath(points)}
                fill="none"
                stroke={entry.color}
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              {points
                .filter((point) => point.value !== null)
                .map((point) => (
                  <circle
                    key={`${entry.id}-${point.x}`}
                    cx={point.x}
                    cy={point.y}
                    r="4"
                    fill="#fffaf8"
                    stroke={entry.color}
                    strokeWidth="2.5"
                  />
                ))}
            </g>
          )
        })}
      </svg>
    </div>
  )
}

function MechanicalPanel({ passes }: { passes: RubricPass[] }) {
  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-5 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <PanelHeader title="Mechanical" note="word count, claim accuracy, total tells" />
      <div className="grid gap-4 xl:grid-cols-2">
        <MiniLineChart
          title="Word count by pass"
          passes={passes}
          series={[
            {
              id: 'target_words',
              label: 'Target',
              color: '#c08457',
              values: passes.map((pass) => pass.metrics.target_words),
            },
            {
              id: 'claimed_words',
              label: 'Claimed',
              color: '#f4b49a',
              values: passes.map((pass) => pass.metrics.claimed_words),
            },
            {
              id: 'actual_words',
              label: 'Actual',
              color: '#d56a6a',
              values: passes.map((pass) => pass.metrics.actual_words),
            },
          ]}
        />
        <MiniLineChart
          title="Total tells by pass"
          passes={passes}
          series={[
            {
              id: 'total_tells',
              label: 'Total tells',
              color: '#7f4a57',
              values: passes.map((pass) => pass.metrics.total_tells),
            },
          ]}
        />
      </div>
    </div>
  )
}

function DeltaPanel({
  trackedTells,
  passes,
}: {
  trackedTells: TrackedTell[]
  passes: RubricPass[]
}) {
  const firstPass = passes[0]
  const lastPass = passes[passes.length - 1]
  const tellDeltas = trackedTells.map((tell) => ({
    ...tell,
    start: firstPass?.tell_counts[tell.id] ?? null,
    end: lastPass?.tell_counts[tell.id] ?? null,
    delta: calculateDelta(firstPass?.tell_counts[tell.id] ?? null, lastPass?.tell_counts[tell.id] ?? null),
  }))
  const totalTellsDelta = calculateDelta(firstPass?.metrics.total_tells ?? null, lastPass?.metrics.total_tells ?? null)
  const actualWordsDelta = calculateDelta(firstPass?.metrics.actual_words ?? null, lastPass?.metrics.actual_words ?? null)

  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-5 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <PanelHeader title="Pass delta" note={`${firstPass?.label ?? 'First'} -> ${lastPass?.label ?? 'Latest'}`} />
      <div className="grid gap-3 md:grid-cols-2">
        <div className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-gray-500">Actual words</p>
          <p className="mt-2 text-2xl font-semibold text-fiamma-text">
            {formatMetric(firstPass?.metrics.actual_words ?? null)} {'->'} {formatMetric(lastPass?.metrics.actual_words ?? null)}
          </p>
          <p className="mt-2 text-sm text-gray-600">{formatSignedDelta(actualWordsDelta)}</p>
        </div>
        <div className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-gray-500">Total tells</p>
          <p className="mt-2 text-2xl font-semibold text-fiamma-text">
            {formatMetric(firstPass?.metrics.total_tells ?? null)} {'->'} {formatMetric(lastPass?.metrics.total_tells ?? null)}
          </p>
          <p className="mt-2 text-sm text-gray-600">{formatSignedDelta(totalTellsDelta)}</p>
        </div>
      </div>
      <div className="mt-4 overflow-x-auto">
        <table className="min-w-full border-separate border-spacing-y-2">
          <thead>
            <tr className="text-left text-[11px] font-semibold uppercase tracking-[0.16em] text-gray-500">
              <th className="pb-2 pr-4">Tell</th>
              <th className="pb-2 pr-4">Start</th>
              <th className="pb-2 pr-4">Latest</th>
              <th className="pb-2 pr-4">Delta</th>
            </tr>
          </thead>
          <tbody>
            {tellDeltas.map((tell) => (
              <tr key={tell.id} className="bg-[#fff8f5] text-sm text-gray-700">
                <td className="rounded-l-2xl px-4 py-3 font-medium text-fiamma-text">{tell.label}</td>
                <td className="px-4 py-3">{formatMetric(tell.start)}</td>
                <td className="px-4 py-3">{formatMetric(tell.end)}</td>
                <td className="rounded-r-2xl px-4 py-3 font-medium text-fiamma-text">{formatSignedDelta(tell.delta)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function TellPassGraph({
  trackedTells,
  passes,
}: {
  trackedTells: TrackedTell[]
  passes: RubricPass[]
}) {
  const width = 1180
  const height = 520
  const paddingLeft = 72
  const paddingRight = 28
  const paddingTop = 28
  const paddingBottom = 170
  const usableWidth = width - paddingLeft - paddingRight
  const usableHeight = height - paddingTop - paddingBottom
  const xStep = trackedTells.length > 1 ? usableWidth / (trackedTells.length - 1) : usableWidth / 2
  const allValues = passes.flatMap((pass) =>
    trackedTells
      .map((tell) => pass.tell_counts[tell.id])
      .filter((value): value is number => typeof value === 'number'),
  )
  const populatedSeriesCount = passes.filter((pass) =>
    trackedTells.some((tell) => typeof pass.tell_counts[tell.id] === 'number'),
  ).length
  const maxValue = Math.max(1, ...allValues)
  const yMax = maxValue <= 12 ? Math.ceil(maxValue) : Math.ceil(maxValue / 5) * 5

  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-5 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <PanelHeader
        title="AI tells"
        note={
          populatedSeriesCount === 0
            ? 'no tell scans recorded for this scope yet'
            : `${populatedSeriesCount} recorded pass${populatedSeriesCount === 1 ? '' : 'es'} with tell counts`
        }
      />
      <svg viewBox={`0 0 ${width} ${height}`} className="h-auto w-full">
        {Array.from({ length: 5 }, (_, index) => {
          const value = (yMax / 4) * index
          const y = paddingTop + usableHeight - (value / yMax) * usableHeight
          return (
            <g key={value}>
              <line x1={paddingLeft} y1={y} x2={width - paddingRight} y2={y} stroke="#f5e6e1" strokeWidth="1" />
              <text x={paddingLeft - 12} y={y + 4} textAnchor="end" className="fill-gray-500 text-[11px] font-medium">
                {formatMetric(value)}
              </text>
            </g>
          )
        })}

        {trackedTells.map((tell, index) => {
          const x = paddingLeft + xStep * index
          return (
            <g key={tell.id}>
              <line x1={x} y1={paddingTop} x2={x} y2={paddingTop + usableHeight} stroke="#faf0ec" strokeWidth="1" />
              <g transform={`translate(${x}, ${height - paddingBottom + 24}) rotate(34)`}>
                <text textAnchor="start" className="fill-gray-600 text-[11px] font-medium">
                  {tell.label}
                </text>
              </g>
            </g>
          )
        })}

        {passes.map((pass, index) => {
          const points = trackedTells.map((tell, tellIndex) => {
            const value = pass.tell_counts[tell.id]
            const x = paddingLeft + xStep * tellIndex
            const y =
              value === null
                ? paddingTop + usableHeight
                : paddingTop + usableHeight - (value / yMax) * usableHeight
            return { x, y, value }
          })

          return (
            <g key={pass.id}>
              <path
                d={buildSeriesPath(points)}
                fill="none"
                stroke={passPalette[index % passPalette.length]}
                strokeWidth="4"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              {points
                .filter((point) => point.value !== null)
                .map((point) => (
                  <circle
                    key={`${pass.id}-${point.x}`}
                    cx={point.x}
                    cy={point.y}
                    r="4.5"
                    fill="#fffaf8"
                    stroke={passPalette[index % passPalette.length]}
                    strokeWidth="3"
                  />
                ))}
            </g>
          )
        })}
      </svg>
      <div className="mt-5 grid gap-3 md:grid-cols-2 xl:grid-cols-4">
        {passes.map((pass, index) => (
          <div key={pass.id} className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
            <div className="flex items-center gap-3">
              <span className="block h-[3px] w-8 rounded-full" style={{ backgroundColor: passPalette[index % passPalette.length] }} />
              <p className="text-sm font-semibold text-fiamma-text">{pass.label}</p>
            </div>
            <p className="mt-2 text-xs leading-5 text-gray-500">{pass.scope}</p>
          </div>
        ))}
      </div>
    </div>
  )
}

function TellMatrix({
  trackedTells,
  passes,
}: {
  trackedTells: TrackedTell[]
  passes: RubricPass[]
}) {
  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-5 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <PanelHeader title="Tell matrix" note="exact counts per pass" />
      <div className="overflow-x-auto">
        <table className="min-w-full border-separate border-spacing-y-2">
          <thead>
            <tr className="text-left text-[11px] font-semibold uppercase tracking-[0.16em] text-gray-500">
              <th className="pb-2 pr-4">Tell</th>
              {passes.map((pass) => (
                <th key={pass.id} className="pb-2 pr-4">
                  {pass.label}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {trackedTells.map((tell) => (
              <tr key={tell.id} className="bg-[#fff8f5] text-sm text-gray-700">
                <td className="rounded-l-2xl px-4 py-3 font-medium text-fiamma-text">{tell.label}</td>
                {passes.map((pass, index) => (
                  <td key={`${tell.id}-${pass.id}`} className={`px-4 py-3 ${index === passes.length - 1 ? 'rounded-r-2xl' : ''}`}>
                    {formatMetric(pass.tell_counts[tell.id] ?? null)}
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function scoreColor(score: number | null) {
  if (score === null) return '#f4efe9'
  if (score < 2) return '#f4b49a'
  if (score < 3) return '#f6d7c9'
  if (score < 4) return '#f9ebdf'
  return '#e8f1eb'
}

function ScoreHeatmap({
  label,
  metrics,
  passes,
  groupId,
}: {
  label: string
  metrics: Array<{ id: string; label: string }>
  passes: RubricPass[]
  groupId: keyof ScorecardGroup
}) {
  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-5 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <PanelHeader title={label} note="raw score or count · grey means unscored" />
      <div className="overflow-x-auto">
        <table className="min-w-full border-separate border-spacing-y-2">
          <thead>
            <tr className="text-left text-[11px] font-semibold uppercase tracking-[0.16em] text-gray-500">
              <th className="pb-2 pr-4">Metric</th>
              {passes.map((pass) => (
                <th key={pass.id} className="pb-2 pr-4">
                  {pass.label}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {metrics.map((metric) => (
              <tr key={metric.id} className="text-sm text-gray-700">
                <td className="rounded-l-2xl bg-[#fff8f5] px-4 py-3 font-medium text-fiamma-text">{metric.label}</td>
                {passes.map((pass, index) => {
                  const score = pass.scorecards[groupId][metric.id] ?? null
                  return (
                    <td
                      key={`${groupId}-${metric.id}-${pass.id}`}
                      className={`px-4 py-3 ${index === passes.length - 1 ? 'rounded-r-2xl' : ''}`}
                      style={{ backgroundColor: scoreColor(score) }}
                    >
                      {score === null ? '—' : formatMetric(score)}
                    </td>
                  )
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function CatchRatePanel({
  gmCaught,
  founderCaught,
  founderInterventions,
  scopeLabel,
}: {
  gmCaught: number | null
  founderCaught: number | null
  founderInterventions: string[]
  scopeLabel: string
}) {
  const total = (gmCaught ?? 0) + (founderCaught ?? 0)
  const gmPct = total > 0 ? Math.round(((gmCaught ?? 0) / total) * 100) : null
  const founderPct = total > 0 ? Math.round(((founderCaught ?? 0) / total) * 100) : null

  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-5 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <PanelHeader title="Editorial catch rate" note={scopeLabel} />
      <div className="grid gap-3 md:grid-cols-3">
        <div className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-gray-500">GM caught first</p>
          <p className="mt-2 text-3xl font-semibold text-fiamma-text">{formatMetric(gmCaught)}</p>
          <p className="mt-2 text-sm text-gray-600">{gmPct === null ? 'No catch data yet' : `${gmPct}% of flagged issues`}</p>
        </div>
        <div className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-gray-500">Founder had to catch</p>
          <p className="mt-2 text-3xl font-semibold text-fiamma-text">{formatMetric(founderCaught)}</p>
          <p className="mt-2 text-sm text-gray-600">
            {founderPct === null ? 'No founder escalations logged' : `${founderPct}% of flagged issues`}
          </p>
        </div>
        <div className="rounded-[1.5rem] bg-fiamma-bg px-4 py-4">
          <p className="text-xs font-semibold uppercase tracking-[0.16em] text-gray-500">Founder interventions</p>
          <p className="mt-2 text-3xl font-semibold text-fiamma-text">{founderInterventions.length}</p>
          <p className="mt-2 text-sm text-gray-600">Persistent misses that changed the editorial plan.</p>
        </div>
      </div>
      {founderInterventions.length > 0 ? (
        <div className="mt-4 flex flex-wrap gap-2">
          {founderInterventions.map((intervention) => (
            <span
              key={intervention}
              className="rounded-full bg-[#fff1ea] px-4 py-2 text-sm text-fiamma-text"
            >
              {intervention}
            </span>
          ))}
        </div>
      ) : null}
    </div>
  )
}

function TellBreakdown({ titles }: { titles: TitleMetrics[] }) {
  const totals: Record<string, number> = {}
  for (const title of titles) {
    const mergedCounts = {
      ...title.tell_counts,
      ...(title.shared_category_counts.em_dashes
        ? { em_dashes: title.shared_category_counts.em_dashes.count }
        : {}),
    }
    for (const [key, value] of Object.entries(mergedCounts)) {
      totals[key] = (totals[key] ?? 0) + value
    }
  }

  const categoryKeys = Object.entries(totals)
    .sort((a, b) => b[1] - a[1])
    .slice(0, 8)
    .map(([key]) => key)

  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-6 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <h3 className="text-xl font-semibold text-fiamma-text">Tell category breakdown</h3>
      <p className="mt-2 max-w-2xl text-sm leading-6 text-gray-600">
        Top high-volume tells across the tracked title set. Full-spectrum counts for AKM-003 surface the frequency patterns that only appeared once em dashes were suppressed.
      </p>
      <div className="mt-6 space-y-5">
        {titles.map((title) => {
          const total = categoryKeys.reduce((sum, key) => sum + countForCategory(title, key), 0)
          return (
            <div key={title.id}>
              <div className="mb-2 flex items-baseline justify-between gap-4">
                <div>
                  <p className="text-base font-semibold text-fiamma-text">{title.run_id}</p>
                  <p className="text-sm text-gray-500">{title.title}</p>
                </div>
                <p className="text-sm font-medium text-gray-500">{formatNumber(total)} visible tell hits</p>
              </div>
              <div className="flex h-5 overflow-hidden rounded-full bg-fiamma-bg">
                {categoryKeys.map((key) => {
                  const value = countForCategory(title, key)
                  const width = total === 0 ? 0 : (value / total) * 100
                  return (
                    <div
                      key={key}
                      className="h-full"
                      style={{
                        width: `${width}%`,
                        backgroundColor: categoryColors[key] ?? '#d56a6a',
                      }}
                      title={`${categoryLabel(key)}: ${value}`}
                    />
                  )
                })}
              </div>
            </div>
          )
        })}
      </div>
      <div className="mt-6 grid gap-3 md:grid-cols-2 xl:grid-cols-4">
        {categoryKeys.map((key) => (
          <div key={key} className="flex items-center gap-3 rounded-2xl bg-fiamma-bg px-4 py-3">
            <span className="h-3 w-3 rounded-full" style={{ backgroundColor: categoryColors[key] ?? '#d56a6a' }} />
            <span className="text-sm text-gray-700">{categoryLabel(key)}</span>
          </div>
        ))}
      </div>
    </div>
  )
}

function ModelComparison({ titles }: { titles: TitleMetrics[] }) {
  const maxValue = Math.max(
    1,
    ...titles.flatMap((title) =>
      sharedComparisonKeys.map((key) => title.shared_category_counts[key]?.count ?? 0),
    ),
  )

  return (
    <div className="rounded-[2rem] border border-white/80 bg-white p-6 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
      <h3 className="text-xl font-semibold text-fiamma-text">Model comparison</h3>
      <p className="mt-2 max-w-2xl text-sm leading-6 text-gray-600">
        Shared categories only. AKM-002 em dashes remain an estimate from the rubric because the detailed scan happened after a separate em-dash pass.
      </p>
      <div className="mt-6 space-y-5">
        {sharedComparisonKeys.map((key) => (
          <div key={key}>
            <div className="mb-2 flex items-center justify-between gap-4">
              <p className="text-sm font-semibold uppercase tracking-[0.14em] text-gray-500">{categoryLabel(key)}</p>
              <p className="text-xs text-gray-400">higher is worse</p>
            </div>
            <div className="grid gap-3">
              {titles.map((title) => {
                const entry = title.shared_category_counts[key]
                const value = entry?.count ?? 0
                const width = (value / maxValue) * 100
                return (
                  <div key={`${key}-${title.id}`} className="grid gap-2 md:grid-cols-[160px_minmax(0,1fr)_72px] md:items-center">
                    <div className="text-sm text-gray-600">
                      {title.model.alias}
                      {entry?.estimated ? ' (est.)' : ''}
                    </div>
                    <div className="h-4 overflow-hidden rounded-full bg-fiamma-bg">
                      <div
                        className="h-full rounded-full"
                        style={{ width: `${width}%`, backgroundColor: title.id === 'akm-003-base-notes' ? '#d56a6a' : '#f4b49a' }}
                      />
                    </div>
                    <div className="text-right text-sm font-medium text-gray-600">{value}</div>
                  </div>
                )
              })}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

function WaterfallRail({ title }: { title: TitleMetrics }) {
  const maxValue = title.editorial_distance.raw || 1
  const stages = [
    { label: 'Raw', value: title.editorial_distance.raw, color: '#d56a6a' },
    { label: 'After HIGH', value: title.editorial_distance.after_high, color: '#f28b82' },
    { label: 'After MED', value: title.editorial_distance.after_medium, color: '#f4b49a' },
    { label: 'After LOW', value: title.editorial_distance.after_low, color: '#d9cfc7' },
    { label: 'Publishable', value: title.editorial_distance.publishable, color: '#2d2d2d' },
  ]

  return (
    <div className="rounded-[2rem] border border-[#f6e5e1] bg-[#fffdfc] p-5">
      <div className="mb-3">
        <p className="text-lg font-semibold text-fiamma-text">{title.run_id}</p>
        <p className="text-sm text-gray-500">{title.editorial_distance.basis}</p>
      </div>
      <div className="space-y-3">
        {stages.map((stage) => (
          <div key={stage.label}>
            <div className="mb-1 flex items-center justify-between text-sm text-gray-600">
              <span>{stage.label}</span>
              <span>{stage.value}</span>
            </div>
            <div className="h-3 overflow-hidden rounded-full bg-fiamma-bg">
              <div
                className="h-full rounded-full"
                style={{
                  width: `${(stage.value / maxValue) * 100}%`,
                  backgroundColor: stage.color,
                }}
              />
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

function ProductionMetrics({ titles }: { titles: TitleMetrics[] }) {
  return (
    <div className="space-y-6">
      {titles.map((title) => (
        <div
          key={title.id}
          className="rounded-[2rem] border border-white/80 bg-white p-6 shadow-[0_24px_80px_rgba(242,139,130,0.10)]"
        >
          <div className="mb-5 flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
            <div>
              <h3 className="text-xl font-semibold text-fiamma-text">
                {title.run_id} production metrics
              </h3>
              <p className="mt-1 text-sm text-gray-500">
                {formatNumber(title.actual_words)} actual words across {title.chapters} chapters
              </p>
            </div>
            <div className="rounded-full bg-fiamma-bg px-4 py-2 text-sm font-medium text-gray-600">
              {title.production.batches ? `${title.production.batches} batches` : 'Single-run metrics only'}
            </div>
          </div>

          <div className="grid gap-4 lg:grid-cols-2">
            <div className="rounded-[1.5rem] bg-fiamma-bg p-5">
              <p className="mb-4 text-sm font-semibold uppercase tracking-[0.16em] text-gray-500">
                Word count fabrication
              </p>
              {title.production.word_count_fabrication_events.length === 0 ? (
                <p className="text-sm leading-6 text-gray-600">No batch-level fabrication data recorded for this title.</p>
              ) : (
                <div className="space-y-4">
                  {title.production.word_count_fabrication_events.map((event) => (
                    <div key={event.label}>
                      <div className="mb-1 flex items-center justify-between gap-4 text-sm text-gray-600">
                        <span>{event.label}</span>
                        <span>{formatPct(event.fabrication_pct)}</span>
                      </div>
                      <div className="h-3 overflow-hidden rounded-full bg-white">
                        <div
                          className="h-full rounded-full bg-fiamma-coral"
                          style={{ width: `${Math.min(event.fabrication_pct, 100)}%` }}
                        />
                      </div>
                      <p className="mt-2 text-xs text-gray-500">
                        Claimed {formatNumber(event.claimed)} vs actual {formatNumber(event.actual)}
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </div>

            <div className="rounded-[1.5rem] bg-fiamma-bg p-5">
              <p className="mb-4 text-sm font-semibold uppercase tracking-[0.16em] text-gray-500">
                Rewrite-from-memory incidents
              </p>
              {title.production.rewrite_from_memory_events.length === 0 ? (
                <p className="text-sm leading-6 text-gray-600">No rewrite-from-memory loss incidents recorded for this title.</p>
              ) : (
                <div className="space-y-4">
                  {title.production.rewrite_from_memory_events.map((event) => (
                    <div key={event.label} className="rounded-2xl bg-white p-4">
                      <div className="flex items-center justify-between gap-4">
                        <p className="text-sm font-semibold text-fiamma-text">{event.label}</p>
                        <p className="text-sm font-medium text-[#8d4a43]">{formatPct(event.loss_pct)} loss</p>
                      </div>
                      <p className="mt-2 text-sm text-gray-600">
                        {formatNumber(event.before)} words to {formatNumber(event.after)} words, a loss of {formatNumber(event.loss)}.
                      </p>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>

          <div className="mt-5 grid gap-4 md:grid-cols-3">
            <StatCard
              label="Target Words"
              value={formatNumber(title.target_words)}
              note="Planned manuscript length at commissioning."
            />
            <StatCard
              label="Actual Words"
              value={formatNumber(title.actual_words)}
              note="Mechanical count, never self-reported by the writing agent."
            />
            <StatCard
              label="Karen 2.0"
              value={title.karen2.relative_quality_score === null ? 'Pending' : String(title.karen2.relative_quality_score)}
              note="Slot reserved only. No live scoring until calibration anchors exist."
            />
          </div>
        </div>
      ))}
    </div>
  )
}

// Legacy dashboard sections kept temporarily while the new pass-data layout settles.
const legacyDashboardSymbols = [
  SectionHeading,
  StatCard,
  PassProfileChart,
  TellBreakdown,
  ModelComparison,
  WaterfallRail,
  ProductionMetrics,
  categoryColors,
  sharedComparisonKeys,
  categoryLabel,
  countForCategory,
  passProfileTotal,
  aggregateModelPassProfiles,
]
void legacyDashboardSymbols

export function EditorialDashboardPage() {
  const [data, setData] = useState<DashboardData | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [viewMode, setViewMode] = useState<'model' | 'title'>('title')
  const [selectedModelId, setSelectedModelId] = useState('')
  const [selectedTitleId, setSelectedTitleId] = useState('')

  useEffect(() => {
    let cancelled = false

    fetch('/data/editorial-quality.json')
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Failed to load dashboard data (${response.status})`)
        }
        return response.json()
      })
      .then((payload) => {
        if (!cancelled) {
          setData(payload as DashboardData)
        }
      })
      .catch((reason: unknown) => {
        if (!cancelled) {
          setError(reason instanceof Error ? reason.message : 'Unknown dashboard data error')
        }
      })

    return () => {
      cancelled = true
    }
  }, [])

  if (error) {
    return (
      <div className="section-padding pt-32">
        <div className="mx-auto max-w-3xl rounded-[2rem] border border-red-100 bg-white p-8 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
          <p className="text-sm font-semibold uppercase tracking-[0.2em] text-red-500">Dashboard Error</p>
          <h1 className="mt-4 text-3xl font-bold text-fiamma-text">Editorial data did not load</h1>
          <p className="mt-4 text-base leading-7 text-gray-600">{error}</p>
        </div>
      </div>
    )
  }

  if (!data) {
    return (
      <div className="section-padding pt-32">
        <div className="mx-auto max-w-3xl rounded-[2rem] border border-white/80 bg-white p-8 shadow-[0_24px_80px_rgba(242,139,130,0.10)]">
          <p className="text-sm font-semibold uppercase tracking-[0.2em] text-fiamma-coral">Loading</p>
          <h1 className="mt-4 text-3xl font-bold text-fiamma-text">Building the editorial baseline</h1>
          <p className="mt-4 text-base leading-7 text-gray-600">
            Pulling rubric data, model comparisons, and production metrics into the dashboard.
          </p>
        </div>
      </div>
    )
  }

  const modelOptions = [...new Map(data.titles.map((title) => [title.model.id, title.model])).values()].sort((left, right) =>
    left.alias.localeCompare(right.alias),
  )
  const titleOptions = [...data.titles].sort((left, right) => left.run_id.localeCompare(right.run_id))
  const tellIds = data.meta.tracked_tells.map((tell) => tell.id)
  const defaultTitleId =
    [...titleOptions].sort((left, right) => {
      const coverageGap = titleTellCoverage(right, tellIds) - titleTellCoverage(left, tellIds)
      if (coverageGap !== 0) return coverageGap
      return right.passes.length - left.passes.length
    })[0]?.id ?? ''
  const defaultModelId =
    [...modelOptions].sort(
      (left, right) => modelTellCoverage(data.titles, right.id, tellIds) - modelTellCoverage(data.titles, left.id, tellIds),
    )[0]?.id ?? ''
  const activeTitleId = titleOptions.some((title) => title.id === selectedTitleId) ? selectedTitleId : defaultTitleId
  const activeModelId = modelOptions.some((model) => model.id === selectedModelId) ? selectedModelId : defaultModelId
  const activeTitle = titleOptions.find((title) => title.id === activeTitleId) ?? titleOptions[0]
  const activeModel = modelOptions.find((model) => model.id === activeModelId) ?? modelOptions[0]
  const scopedTitles =
    viewMode === 'model'
      ? data.titles.filter((title) => title.model.id === activeModel?.id)
      : activeTitle
        ? [activeTitle]
        : []
  const activePasses =
    viewMode === 'model'
      ? aggregateModelPasses(data.titles, activeModel?.id ?? '', tellIds)
      : activeTitle?.passes ?? []
  const activeEditorialCatch =
    viewMode === 'model'
      ? aggregateEditorialCatch(data.titles, activeModel?.id ?? '')
      : activeTitle?.editorial_catch ?? { gm_caught: null, founder_caught: null, founder_interventions: [] }
  const scopeLabel =
    viewMode === 'model'
      ? `${activeModel?.alias ?? 'Model'} averaged across ${data.titles.filter((title) => title.model.id === activeModel?.id).length} title${
          data.titles.filter((title) => title.model.id === activeModel?.id).length === 1 ? '' : 's'
        }`
      : `${activeTitle?.run_id ?? 'Title'} · ${activeTitle?.model.alias ?? ''}`

  return (
    <div className="min-h-screen bg-[radial-gradient(circle_at_top_left,_rgba(242,139,130,0.12),_transparent_34%),linear-gradient(180deg,_#fffaf8_0%,_#fff6f1_42%,_#fffaf8_100%)] text-fiamma-text">
      <section className="section-padding pt-24 md:pt-28">
        <div className="mx-auto max-w-7xl space-y-6">
          <div className="flex flex-col gap-5 xl:flex-row xl:items-end xl:justify-between">
            <div>
              <p className="text-xs font-semibold uppercase tracking-[0.22em] text-fiamma-coral">Editorial Scoreboard</p>
              <h1 className="mt-2 text-4xl font-bold text-fiamma-text md:text-5xl">Pass Scoreboard</h1>
              <p className="mt-3 text-sm leading-6 text-gray-600">
                {scopeLabel} · data stamp {data.meta.generated_at.slice(0, 10)}
              </p>
            </div>
            <DashboardControls
              viewMode={viewMode}
              onViewModeChange={setViewMode}
              selectedId={viewMode === 'model' ? activeModel?.id ?? '' : activeTitle?.id ?? ''}
              onSelectedIdChange={(value) => {
                if (viewMode === 'model') {
                  setSelectedModelId(value)
                } else {
                  setSelectedTitleId(value)
                }
              }}
              modelOptions={modelOptions}
              titleOptions={titleOptions}
            />
          </div>

          <PassStrip passes={activePasses} />
        </div>
      </section>

      <section className="section-padding pt-0">
        <div className="mx-auto grid max-w-7xl gap-6 xl:grid-cols-[0.92fr_1.08fr]">
          <MechanicalPanel passes={activePasses} />
          <DeltaPanel trackedTells={data.meta.tracked_tells} passes={activePasses} />
        </div>
      </section>

      <section className="section-padding pt-0">
        <div className="mx-auto max-w-7xl">
          <TellPassGraph trackedTells={data.meta.tracked_tells} passes={activePasses} />
        </div>
      </section>

      <section className="section-padding pt-0">
        <div className="mx-auto max-w-7xl">
          <TellMatrix trackedTells={data.meta.tracked_tells} passes={activePasses} />
        </div>
      </section>

      <section className="section-padding pt-0">
        <div className="mx-auto grid max-w-7xl gap-6 xl:grid-cols-2">
          {scoreGroups.map((group) => (
            <ScoreHeatmap
              key={group.id}
              label={group.label}
              metrics={[...group.metrics]}
              passes={activePasses}
              groupId={group.id}
            />
          ))}
        </div>
      </section>

      <section className="section-padding pt-0">
        <div className="mx-auto max-w-7xl">
          <CatchRatePanel
            gmCaught={activeEditorialCatch.gm_caught}
            founderCaught={activeEditorialCatch.founder_caught}
            founderInterventions={activeEditorialCatch.founder_interventions}
            scopeLabel={
              viewMode === 'model'
                ? `${activeModel?.alias ?? 'Model'} across ${scopedTitles.length} title${scopedTitles.length === 1 ? '' : 's'}`
                : `${activeTitle?.run_id ?? 'Title'} review history`
            }
          />
        </div>
      </section>

      <section className="pb-16">
        <div className="mx-auto max-w-7xl px-1 text-xs uppercase tracking-[0.16em] text-gray-500">
          {data.meta.notes.join(' · ')}
        </div>
      </section>
    </div>
  )
}
