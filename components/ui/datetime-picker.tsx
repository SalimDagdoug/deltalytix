"use client"

import * as React from "react"
import { format, parse, isValid } from "date-fns"
import { CalendarIcon, Clock } from "lucide-react"

import { cn } from "@/lib/utils"
import { Button } from "@/components/ui/button"
import { Calendar } from "@/components/ui/calendar"
import { Input } from "@/components/ui/input"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover"

interface DateTimePickerProps {
  value: string // ISO string or datetime-local format
  onChange: (value: string) => void
  placeholder?: string
  className?: string
  disabled?: boolean
}

export function DateTimePicker({
  value,
  onChange,
  placeholder = "Pick a date and time",
  className,
  disabled = false,
}: DateTimePickerProps) {
  const [open, setOpen] = React.useState(false)
  
  // Parse the value to a Date object
  const dateValue = React.useMemo(() => {
    if (!value) return undefined
    const date = new Date(value)
    return isValid(date) ? date : undefined
  }, [value])
  
  // Extract hours and minutes
  const hours = dateValue ? dateValue.getHours().toString().padStart(2, '0') : '12'
  const minutes = dateValue ? dateValue.getMinutes().toString().padStart(2, '0') : '00'

  const handleDateSelect = (date: Date | undefined) => {
    if (!date) {
      onChange('')
      return
    }
    
    // Preserve the existing time if we have one, otherwise use current time
    const currentHours = dateValue ? dateValue.getHours() : new Date().getHours()
    const currentMinutes = dateValue ? dateValue.getMinutes() : new Date().getMinutes()
    
    date.setHours(currentHours, currentMinutes, 0, 0)
    onChange(format(date, "yyyy-MM-dd'T'HH:mm"))
  }

  const handleTimeChange = (type: 'hours' | 'minutes', newValue: string) => {
    const numValue = parseInt(newValue, 10)
    if (isNaN(numValue)) return
    
    const date = dateValue ? new Date(dateValue) : new Date()
    
    if (type === 'hours') {
      if (numValue >= 0 && numValue <= 23) {
        date.setHours(numValue)
      }
    } else {
      if (numValue >= 0 && numValue <= 59) {
        date.setMinutes(numValue)
      }
    }
    
    onChange(format(date, "yyyy-MM-dd'T'HH:mm"))
  }

  const setNow = () => {
    const now = new Date()
    onChange(format(now, "yyyy-MM-dd'T'HH:mm"))
  }

  return (
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger asChild>
        <Button
          variant="outline"
          className={cn(
            "w-full justify-start text-left font-normal",
            !dateValue && "text-muted-foreground",
            className
          )}
          disabled={disabled}
        >
          <CalendarIcon className="mr-2 h-4 w-4" />
          {dateValue ? format(dateValue, "PPP HH:mm") : <span>{placeholder}</span>}
        </Button>
      </PopoverTrigger>
      <PopoverContent className="w-auto p-0" align="start">
        <Calendar
          mode="single"
          selected={dateValue}
          onSelect={handleDateSelect}
          initialFocus
        />
        <div className="border-t p-3 space-y-3">
          <div className="flex items-center gap-2">
            <Clock className="h-4 w-4 text-muted-foreground" />
            <span className="text-sm font-medium">Time</span>
          </div>
          <div className="flex items-center gap-2">
            <Input
              type="number"
              min={0}
              max={23}
              value={hours}
              onChange={(e) => handleTimeChange('hours', e.target.value)}
              className="w-16 text-center"
              placeholder="HH"
            />
            <span className="text-lg font-bold">:</span>
            <Input
              type="number"
              min={0}
              max={59}
              value={minutes}
              onChange={(e) => handleTimeChange('minutes', e.target.value)}
              className="w-16 text-center"
              placeholder="MM"
            />
          </div>
          <Button 
            variant="outline" 
            size="sm" 
            className="w-full"
            onClick={setNow}
          >
            Set to Now
          </Button>
        </div>
      </PopoverContent>
    </Popover>
  )
}
