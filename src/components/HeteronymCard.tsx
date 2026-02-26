import { useEffect, useMemo, useRef, useState } from 'react'

type HeteronymStatus = 'active' | 'upcoming'

export interface HeteronymCardData {
  name: string
  slug: string
  bio: string
  imagePath: string
  videoPath?: string
  status: HeteronymStatus
}

type HeteronymCardProps = HeteronymCardData

function bindMediaQueryListener(query: MediaQueryList, listener: () => void) {
  if (typeof query.addEventListener === 'function') {
    query.addEventListener('change', listener)
    return () => query.removeEventListener('change', listener)
  }

  query.addListener(listener)
  return () => query.removeListener(listener)
}

export function HeteronymCard({ name, slug, bio, imagePath, videoPath, status }: HeteronymCardProps) {
  const videoRef = useRef<HTMLVideoElement>(null)
  const [isImageMissing, setIsImageMissing] = useState(false)
  const [isVideoMissing, setIsVideoMissing] = useState(false)
  const [canAnimate, setCanAnimate] = useState(false)
  const [isVideoActive, setIsVideoActive] = useState(false)

  const initials = useMemo(
    () =>
      name
        .split(/[\s-]+/)
        .filter(Boolean)
        .map((chunk) => chunk[0]?.toUpperCase() ?? '')
        .filter(Boolean)
        .slice(0, 3)
        .join(''),
    [name],
  )

  useEffect(() => {
    if (typeof window === 'undefined') return

    const reducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)')
    const hoverCapable = window.matchMedia('(hover: hover)')
    const coarsePointer = window.matchMedia('(pointer: coarse)')

    const evaluateMotionSupport = () => {
      setCanAnimate(hoverCapable.matches && !coarsePointer.matches && !reducedMotion.matches)
    }

    evaluateMotionSupport()

    const unbinders = [
      bindMediaQueryListener(reducedMotion, evaluateMotionSupport),
      bindMediaQueryListener(hoverCapable, evaluateMotionSupport),
      bindMediaQueryListener(coarsePointer, evaluateMotionSupport),
    ]

    return () => {
      unbinders.forEach((unbind) => unbind())
    }
  }, [])

  useEffect(() => {
    if (!canAnimate && isVideoActive) {
      const video = videoRef.current
      if (video) {
        video.pause()
        video.currentTime = 0
      }
    }
  }, [canAnimate, isVideoActive])

  const hasHoverVideo = Boolean(videoPath) && !isVideoMissing

  const handlePointerEnter = async (event: React.PointerEvent<HTMLElement>) => {
    if (!canAnimate || event.pointerType !== 'mouse' || !hasHoverVideo) return
    const video = videoRef.current
    if (!video) return

    try {
      video.currentTime = 0
      await video.play()
      setIsVideoActive(true)
    } catch {
      setIsVideoActive(false)
    }
  }

  const handlePointerLeave = () => {
    const video = videoRef.current
    if (video) {
      video.pause()
      video.currentTime = 0
    }
    setIsVideoActive(false)
  }

  const statusClasses =
    status === 'active' ? 'border-emerald-200 bg-emerald-50 text-emerald-700' : 'border-amber-200 bg-amber-50 text-amber-700'

  return (
    <article
      className="rounded-2xl border-2 border-gray-100 bg-white p-4 shadow-sm transition-colors duration-300 hover:border-fiamma-coral/50 sm:p-5"
      onPointerEnter={handlePointerEnter}
      onPointerLeave={handlePointerLeave}
    >
      <div className="mb-5 overflow-hidden rounded-xl bg-gradient-to-br from-fiamma-coral/20 via-orange-50 to-rose-50">
        <div className="relative aspect-[3/4] w-full">
          {isImageMissing ? (
            <div className="flex h-full w-full items-center justify-center bg-gradient-to-br from-gray-100 to-gray-200">
              <span className="font-display text-5xl font-bold tracking-wide text-gray-500">{initials}</span>
            </div>
          ) : (
            <img
              src={imagePath}
              alt={`${name} portrait`}
              className="h-full w-full object-cover"
              loading="lazy"
              onError={() => setIsImageMissing(true)}
            />
          )}

          {hasHoverVideo && canAnimate ? (
            <video
              ref={videoRef}
              src={videoPath}
              muted
              playsInline
              preload="metadata"
              className={`absolute inset-0 h-full w-full object-cover transition-opacity duration-300 ${
                isVideoActive ? 'opacity-100' : 'opacity-0'
              }`}
              onError={() => setIsVideoMissing(true)}
            />
          ) : null}
        </div>
      </div>

      <div className="mb-3 flex items-start justify-between gap-3">
        <h3 className="font-display text-2xl font-bold leading-tight text-fiamma-text">{name}</h3>
        <span className={`rounded-full border px-3 py-1 text-xs font-semibold uppercase tracking-wide ${statusClasses}`}>
          {status}
        </span>
      </div>

      <p className="mb-3 text-xs uppercase tracking-[0.2em] text-gray-400">{slug}</p>
      <p className="text-sm leading-relaxed text-gray-600 sm:text-base">{bio}</p>
    </article>
  )
}
