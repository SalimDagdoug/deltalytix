import { Resend } from 'resend'

let resend: Resend | null = null

export const getResendClient = () => {
  if (!resend) {
    if (!process.env.RESEND_API_KEY) {
      console.warn('RESEND_API_KEY is not defined')
    }
    resend = new Resend(process.env.RESEND_API_KEY)
  }
  return resend
}
