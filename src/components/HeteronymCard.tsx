import { useCallback, useEffect, useMemo, useRef, useState } from 'react'

type HeteronymStatus = 'active' | 'upcoming'

export interface HeteronymCardData {
  name: string
  slug: string
  bio: string
  imagePath: string
  status: HeteronymStatus
}

type HeteronymCardProps = HeteronymCardData

const CARD_BASE_TRANSFORM = 'perspective(1000px) rotateX(0deg) rotateY(0deg)'
const MEDIA_BASE_TRANSFORM = 'translate3d(0px, 0px, 0px) scale(1)'

function bindMediaQueryListener(query: MediaQueryList, listener: () => void) {
  if (typeof query.addEventListener === 'function') {
    query.addEventListener('change', listener)
    return () => query.removeEventListener('change', listener)
  }

  query.addListener(listener)
  return () => query.removeListener(listener)
}

export function HeteronymCard({ name, slug, bio, imagePath, status }: HeteronymCardProps) {
  const cardRef = useRef<HTMLElement>(null)
  const mediaRef = useRef<HTMLDivElement>(null)
  const [isImageMissing, setIsImageMissing] = useState(false)
  const [canAnimate, setCanAnimate] = useState(false)

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

  const resetTransforms = useCallback(() => {
    if (!cardRef.current || !mediaRef.current) return
    cardRef.current.style.transform = CARD_BASE_TRANSFORM
    mediaRef.current.style.transform = MEDIA_BASE_TRANSFORM
  }, [])

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
    if (!canAnimate) resetTransforms()
  }, [canAnimate, resetTransforms])

  const handlePointerMove = (event: React.PointerEvent<HTMLElement>) => {
    if (!canAnimate || event.pointerType !== 'mouse') return
    if (!cardRef.current || !mediaRef.current) return

    const bounds = cardRef.current.getBoundingClientRect()
    const pointerX = (event.clientX - bounds.left) / bounds.width - 0.5
    const pointerY = (event.clientY - bounds.top) / bounds.height - 0.5

    const rotateX = pointerY * -8
    const rotateY = pointerX * 8
    const shiftX = pointerX * 20
    const shiftY = pointerY * 20

    cardRef.current.style.transitionDuration = '90ms'
    mediaRef.current.style.transitionDuration = '90ms'

    cardRef.current.style.transform = `perspective(1000px) rotateX(${rotateX.toFixed(2)}deg) rotateY(${rotateY.toFixed(2)}deg)`
    mediaRef.current.style.transform = `translate3d(${shiftX.toFixed(1)}px, ${shiftY.toFixed(1)}px, 0) scale(1.08)`
  }

  const handlePointerLeave = () => {
    if (!canAnimate) return
    if (!cardRef.current || !mediaRef.current) return

    cardRef.current.style.transitionDuration = '320ms'
    mediaRef.current.style.transitionDuration = '320ms'
    resetTransforms()
  }

  const statusClasses =
    status === 'active' ? 'border-emerald-200 bg-emerald-50 text-emerald-700' : 'border-amber-200 bg-amber-50 text-amber-700'

  return (
    <article
      ref={cardRef}
      className="rounded-2xl border-2 border-gray-100 bg-white p-4 shadow-sm transition-colors duration-300 hover:border-fiamma-coral/50 sm:p-5"
      style={{
        transform: CARD_BASE_TRANSFORM,
        transitionDuration: '320ms',
        transitionProperty: 'transform',
        transitionTimingFunction: 'cubic-bezier(0.22, 1, 0.36, 1)',
      }}
      onPointerMove={handlePointerMove}
      onPointerLeave={handlePointerLeave}
    >
      <div className="mb-5 overflow-hidden rounded-xl bg-gradient-to-br from-fiamma-coral/20 via-orange-50 to-rose-50">
        <div
          ref={mediaRef}
          className="aspect-[3/4] w-full will-change-transform"
          style={{
            transform: MEDIA_BASE_TRANSFORM,
            transitionDuration: '320ms',
            transitionProperty: 'transform',
            transitionTimingFunction: 'cubic-bezier(0.22, 1, 0.36, 1)',
          }}
        >
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
