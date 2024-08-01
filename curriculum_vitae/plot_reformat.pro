; A plot of total output of publications and outreach, as per my reformatted CV, using the new NRC guidelines.  Note that those rules allow peer-reviewed conference proceedings to appear in the refereed column, and all other contributions fall under "conference", unless they are technical reports, white papers, or posters. This outputs an image of the plots which fits into the online webpage CV.

pro plot_reformat

; inputs
born = 1971
thesis = 1995
dissertation = 2001
postdoc = 2003
baseline = 2001 ; 2001 ; 2000 ; 1999 ; 1998 ; 1995
continuing = 2013
covid = 2019 ; 2020
retirement = 2036 ; 2026 ; 2029 ; 2036 (55, 60, or 65)

; setup
window, 1, xsize = 900, ysize = 1100, title='Cumulative publications and outreach for Eric Steinbring'
wshow, 1
!p.multi = [0, 1, 2]
charsize = 2. ; 3. ; 2.5 ; 2.25
!p.background = 255
loadct, 39, /silent
color_refereed = 250
color_conference = 50
color_invited = 250
color_contributed = 50
charthick = 1 ; 1 ; 2
charsize_text = charsize-0.25 ; charsize-0.5 ; charsize-1.

; read in data
rdfloat, 'plot_reformat_2024.txt', year, refereed, conference, other_publications, invited, contributed, other_outreach, /silent
year = year + 1 ; shift the year that is read in by one, that is, report all publications to end of calendar year
years = n_elements(year)
first_year = year(0)
last_year = year(years - 1)

; calculations
retiring = retirement - born
career = retirement - last_year + 1 ; calculated to the end of that year
thesis = thesis - first_year
dissertation = dissertation - first_year
postdoc = postdoc - first_year
baseline = baseline - first_year
continuing = continuing - first_year
covid = covid - first_year
retirement = retirement - first_year
publications = refereed + conference + other_publications
outreach = invited + contributed + other_outreach
output = publications + outreach
print, 'Year of first publication: ', floor(first_year)
print, 'Retiring at age: ', retiring

; calculate output
print, 'Output'
print, 'Current as of ', floor(last_year-1)

; report
print, 'Total refereed, conference, publications, invited, contributed, outreach:'
print, floor(total(refereed)), floor(total(conference)), floor(total(publications)), floor(total(invited)), floor(total(contributed)), floor(total(outreach))
print, 'Total output:'
print, floor(total(output))

; calculate cumulative results
refereed = total(refereed, /cumulative)
conference = total(conference, /cumulative)
publications = total(publications, /cumulative)
invited = total(invited, /cumulative)
contributed = total(contributed, /cumulative)
outreach = total(outreach, /cumulative)
output = total(output, /cumulative)

; set plot limits
limit = max([publications, outreach])
limit_publications = max(publications) + 50
limit_outreach = max(outreach) + 30

; calculate rates
slope_refereed = refereed(years - 1) - refereed(years - 2)
slope_conference = conference(years - 1) - conference(years - 2)
slope_publications = publications(years - 1) - publications(years - 2)
slope_invited = invited(years - 1) - invited(years - 2)
slope_contributed = contributed(years - 1) - contributed(years - 2)
slope_outreach = outreach(years - 1) - outreach(years - 2)
slope_output = output(years - 1) - output(years - 2)
print, 'Rates'
print, 'Current refereed, conference, publications, invited, contributed, and outreach:'
print, floor(slope_refereed), floor(slope_conference), floor(slope_publications), floor(slope_invited), floor(slope_contributed), floor(slope_outreach)
;print, 'Currrent output per year:'
;print, floor(slope_output)

; and extend this for five years
refereed_extension = fltarr(6)
refereed_extension(0) = refereed(years - 1)
refereed_extension(1) = refereed_extension(0) + slope_refereed 
refereed_extension(2) = refereed_extension(1) + slope_refereed
refereed_extension(3) = refereed_extension(2) + slope_refereed
refereed_extension(4) = refereed_extension(3) + slope_refereed
refereed_extension(5) = refereed_extension(4) + slope_refereed
conference_extension = fltarr(6)
conference_extension(0) = conference(years - 1)
conference_extension(1) = conference_extension(0) + slope_conference 
conference_extension(2) = conference_extension(1) + slope_conference
conference_extension(3) = conference_extension(2) + slope_conference
conference_extension(4) = conference_extension(3) + slope_conference
conference_extension(5) = conference_extension(4) + slope_conference
publications_extension = fltarr(6)
publications_extension(0) = publications(years - 1)
publications_extension(1) = publications_extension(0) + slope_publications 
publications_extension(2) = publications_extension(1) + slope_publications
publications_extension(3) = publications_extension(2) + slope_publications
publications_extension(4) = publications_extension(3) + slope_publications
publications_extension(5) = publications_extension(4) + slope_publications
invited_extension = fltarr(6)
invited_extension(0) = invited(years - 1)
invited_extension(1) = invited_extension(0) + slope_invited 
invited_extension(2) = invited_extension(1) + slope_invited
invited_extension(3) = invited_extension(2) + slope_invited
invited_extension(4) = invited_extension(3) + slope_invited
invited_extension(5) = invited_extension(4) + slope_invited
contributed_extension = fltarr(6)
contributed_extension(0) = contributed(years - 1)
contributed_extension(1) = contributed_extension(0) + slope_contributed 
contributed_extension(2) = contributed_extension(1) + slope_contributed
contributed_extension(3) = contributed_extension(2) + slope_contributed
contributed_extension(4) = contributed_extension(3) + slope_contributed
contributed_extension(5) = contributed_extension(4) + slope_contributed
outreach_extension = fltarr(6)
outreach_extension(0) = outreach(years - 1)
outreach_extension(1) = outreach_extension(0) + slope_outreach 
outreach_extension(2) = outreach_extension(1) + slope_outreach
outreach_extension(3) = outreach_extension(2) + slope_outreach
outreach_extension(4) = outreach_extension(3) + slope_outreach
outreach_extension(5) = outreach_extension(4) + slope_outreach
output_extension = fltarr(6)
output_extension(0) = output(years - 1)
output_extension(1) = output_extension(0) + slope_output 
output_extension(2) = output_extension(1) + slope_output
output_extension(3) = output_extension(2) + slope_output
output_extension(4) = output_extension(3) + slope_output
output_extension(5) = output_extension(4) + slope_output

; average output
print, 'Five-year average at the end of ', floor(last_year-1)

; and average, based on a linear fit
slope_refereed = linfit(year(baseline:*), refereed(baseline:*), yfit=refereed_fit)
slope_conference = linfit(year(baseline:*), conference(baseline:*), yfit=conference_fit)
slope_publications = linfit(year(baseline:*), publications(baseline:*), yfit=publications_fit)
slope_invited = linfit(year(baseline:*), invited(baseline:*), yfit=invited_fit)
slope_contributed = linfit(year(baseline:*), contributed(baseline:*), yfit=contributed_fit)
slope_outreach = linfit(year(baseline:*), outreach(baseline:*), yfit=outreach_fit)
slope_output = linfit(year(baseline:*), output(baseline:*), yfit=output_fit)
slope_refereed = slope_refereed(1)
slope_conference = slope_conference(1)
slope_publications = slope_publications(1)
slope_invited = slope_invited(1)
slope_contributed = slope_contributed(1)
slope_outreach = slope_outreach(1)
slope_output = slope_output(1)
print, 'Average refereed, conference, publications, invited, contributed, and outreach:'
print, slope_refereed, slope_conference, slope_publications, slope_invited, slope_contributed, slope_outreach
;print, 'Average output per year:'
;print, slope_output

; extend this prediction for five years
refereed_prediction = fltarr(6)
refereed_prediction(0) = refereed(years - 1)
refereed_prediction(1) = refereed_prediction(0) + slope_refereed
refereed_prediction(2) = refereed_prediction(1) + slope_refereed
refereed_prediction(3) = refereed_prediction(2) + slope_refereed
refereed_prediction(4) = refereed_prediction(3) + slope_refereed
refereed_prediction(5) = refereed_prediction(4) + slope_refereed
conference_prediction = fltarr(6)
conference_prediction(0) = conference(years - 1)
conference_prediction(1) = conference_prediction(0) + slope_conference
conference_prediction(2) = conference_prediction(1) + slope_conference
conference_prediction(3) = conference_prediction(2) + slope_conference
conference_prediction(4) = conference_prediction(3) + slope_conference
conference_prediction(5) = conference_prediction(4) + slope_conference
publications_prediction = fltarr(6)
publications_prediction(0) = publications(years - 1)
publications_prediction(1) = publications_prediction(0) + slope_publications
publications_prediction(2) = publications_prediction(1) + slope_publications
publications_prediction(3) = publications_prediction(2) + slope_publications
publications_prediction(4) = publications_prediction(3) + slope_publications
publications_prediction(5) = publications_prediction(4) + slope_publications
invited_prediction = fltarr(6)
invited_prediction(0) = invited(years - 1)
invited_prediction(1) = invited_prediction(0) + slope_invited
invited_prediction(2) = invited_prediction(1) + slope_invited
invited_prediction(3) = invited_prediction(2) + slope_invited
invited_prediction(4) = invited_prediction(3) + slope_invited
invited_prediction(5) = invited_prediction(4) + slope_invited
contributed_prediction = fltarr(6)
contributed_prediction(0) = contributed(years - 1)
contributed_prediction(1) = contributed_prediction(0) + slope_contributed
contributed_prediction(2) = contributed_prediction(1) + slope_contributed
contributed_prediction(3) = contributed_prediction(2) + slope_contributed
contributed_prediction(4) = contributed_prediction(3) + slope_contributed
contributed_prediction(5) = contributed_prediction(4) + slope_contributed
outreach_prediction = fltarr(6)
outreach_prediction(0) = outreach(years - 1)
outreach_prediction(1) = outreach_prediction(0) + slope_outreach
outreach_prediction(2) = outreach_prediction(1) + slope_outreach
outreach_prediction(3) = outreach_prediction(2) + slope_outreach
outreach_prediction(4) = outreach_prediction(3) + slope_outreach
outreach_prediction(5) = outreach_prediction(4) + slope_outreach
output_prediction = fltarr(6)
output_prediction(0) = output(years - 1)
output_prediction(1) = output_prediction(0) + slope_output
output_prediction(2) = output_prediction(1) + slope_output
output_prediction(3) = output_prediction(2) + slope_output
output_prediction(4) = output_prediction(3) + slope_output
output_prediction(5) = output_prediction(4) + slope_output

; and at retirement
refereed_career = refereed(years - 1) + slope_refereed*career
conference_career = conference(years - 1) + slope_conference*career
publications_career = publications(years - 1) + slope_publications*career
invited_career = invited(years - 1) + slope_invited*career
contributed_career = contributed(years - 1) + slope_contributed*career
outreach_career = outreach(years - 1) + slope_outreach*career
output_career = output(years - 1) + slope_output*career

; predict output
print, 'Predictions'
print, 'At the end of ', floor(last_year)
print, 'Refereed, conference, publications, invited, contributed, and outreach:'
print, floor(refereed_prediction(1)), floor(conference_prediction(1)), floor(publications_prediction(1)), floor(invited_prediction(1)), floor(contributed_prediction(1)), floor(outreach_prediction(1))
;print, 'Total: ', floor(output_prediction(1))
print, 'At the end of ', floor(last_year+4)
print, floor(refereed_prediction(4)), floor(conference_prediction(4)), floor(publications_prediction(4)), floor(invited_prediction(4)), floor(contributed_prediction(4)), floor(outreach_prediction(4))
;print, 'Total: ', floor(output_prediction(4))
print, 'Career at retirement'
print, floor(refereed_career), floor(conference_career), floor(publications_career), floor(invited_career), floor(contributed_career), floor(outreach_career)
;print, 'Total: ', floor(output_career)

; plot publications
limit = limit_publications
future = [year(years-1), year(years-1) + 1, year(years-1) + 2, year(years-1) + 3, year(years-1) + 4, year(years-1) + 5]
;plot, year, publications, thick=2, xtitle='Year', ytitle='Publications', xstyle=1, ystyle=1, xrange=[first_year-1,last_year+5], yrange=[0,limit], charsize=charsize, color=0
plot, year, publications, thick=2, ytitle='Publications', xstyle=1, ystyle=1, xrange=[first_year-1,last_year+5], yrange=[0,limit], ymargin=[1,1], charsize=charsize, charthick=charthick, color=0
; shading
loadct, 0, /silent ; greyscale
for i = 0, 2 do begin ; 3 do begin
 oplot, [year(covid), year(covid)]+0.5+i, [0., limit], thick=25, color=200
endfor
;; and a quadratic fit to all
;;quadratic_publications = poly_fit(year(*), publications(*), 2, yfit=quadratic_publications_fit)
;;oplot, year, quadratic_publications_fit, thick=3, color=150
;quadratic_publications = poly_fit(year(baseline:*), publications(baseline:*), 2, yfit=quadratic_publications_fit)
;oplot, year(baseline:*), quadratic_publications_fit, thick=3, color=150
loadct, 39, /silent ; back to colour
; limits
oplot, [year(baseline), year(baseline)], [0., limit], linestyle=1, color=0
oplot, [year(thesis), year(thesis)], [0., limit], color=0
oplot, [year(dissertation), year(dissertation)], [0., limit], color=0
oplot, [year(postdoc), year(postdoc)], [0., limit], color=0
oplot, [year(continuing), year(continuing)], [0., limit], color=0
oplot, [year(covid), year(covid)], [0., limit], color=0
;oplot, [year(retirement), year(retirement)], [0., limit], color=0
;oplot, [0, max(year)+5], [100, 100], linestyle=1, color=0
; plots
oplot, year, publications, thick=2, color=0
oplot, year, refereed+conference, thick=2, color=color_conference
oplot, year, refereed, thick=2, color=color_refereed
oplot, future, publications_extension, linestyle=2, color=0
oplot, future, refereed_extension, linestyle=2, color=color_refereed
oplot, future, refereed_extension+conference_extension, linestyle=2, color=color_conference
oplot, year(baseline:*), publications_fit, color=0
oplot, year(baseline:*), refereed_fit, color=color_refereed
oplot, year(baseline:*), refereed_fit+conference_fit, color=color_conference
oplot, future, publications_prediction, linestyle=3, color=0
oplot, future, refereed_prediction, linestyle=3, color=color_refereed
oplot, future, refereed_prediction+conference_prediction, linestyle=3, color=color_conference
; labels
xyouts, thesis+first_year - 0.25, limit - 5, 'Thesis', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, dissertation+first_year - 0.25, limit - 5, 'Dissertation', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, postdoc+first_year - 0.25, limit - 5, 'Postdoc', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, postdoc+first_year + 1., limit - 5, 'Hired as RO at NRC', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, continuing+first_year + 1., limit - 5, 'Continuing, Staff', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, covid+first_year + 1., limit - 5, 'Pandemic', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, retirement+first_year + 1., limit - 5, 'Retirement', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, last_year - 1.75, refereed(last_year-first_year) - 15, 'Peer-', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, refereed(last_year-first_year) - 25, 'reviewed', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, refereed(last_year-first_year)+conference(last_year-first_year) - 15, 'Including', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, refereed(last_year-first_year)+conference(last_year-first_year) - 25, 'conf., and', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, refereed(last_year-first_year)+conference(last_year-first_year) - 35, 'newsletters', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, publications(last_year-first_year) - 30, 'Total, incl.', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, publications(last_year-first_year) - 40, 'technical', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, publications(last_year-first_year) - 50, 'reports', alignment=0., orientation=0., charsize=charsize_text, color=0
; clean up
axis, xaxis=0, color=0, xstyle=1, xrange=[first_year-1,last_year+5], charsize=charsize
axis, xaxis=1, color=0, xstyle=1, xrange=[first_year-1,last_year+5], xtickformat='(A1)'
axis, yaxis=0, color=0, ystyle=1, yrange=[0., limit], charsize=charsize
axis, yaxis=1, color=0, ystyle=1, yrange=[0., limit], ytickformat='(A1)'

; plot outreach
limit = limit_outreach
plot, year, outreach, thick=2, xtitle='Year (Note: with output plotted at the end of each calendar year)', ytitle='Talks and other outreach', xstyle=1, ystyle=1, xrange=[first_year-1,last_year+5], yrange=[0,limit], ymargin=[4, 1], charsize=charsize, charthick=charthick, color=0
; shading
loadct, 0, /silent ; greyscale
for i = 0, 2 do begin ; 3 do begin
 oplot, [year(covid), year(covid)]+0.5+i, [0., limit], thick=25, color=200
endfor
;; and a quadratic fit to all
;;quadratic_outreach = poly_fit(year(*), outreach(*), 2, yfit=quadratic_outreach_fit)
;;oplot, year, quadratic_outreach_fit, thick=3, color=150
;quadratic_outreach = poly_fit(year(baseline:*), outreach(baseline:*), 2, yfit=quadratic_outreach_fit)
;oplot, year(baseline:*), quadratic_outreach_fit, thick=3, color=150
loadct, 39, /silent ; back to colour
; limits
oplot, [year(baseline), year(baseline)], [0., limit], linestyle=1, color=0
oplot, [year(thesis), year(thesis)], [0., limit], color=0
oplot, [year(dissertation), year(dissertation)], [0., limit], color=0
oplot, [year(postdoc), year(postdoc)], [0., limit], color=0
oplot, [year(continuing), year(continuing)], [0., limit], color=0
oplot, [year(covid), year(covid)], [0., limit], color=0
;oplot, [year(retirement), year(retirement)], [0., limit], color=0
;oplot, [0, max(year)+5], [100, 100], linestyle=1, color=0
; plots
oplot, year, outreach, thick=2, color=0
oplot, year, invited+contributed, thick=2, color=color_contributed
oplot, year, invited, thick=2, color=color_refereed
oplot, future, outreach_extension, linestyle=2, color=0
oplot, future, invited_extension, linestyle=2, color=color_invited
oplot, future, invited_extension+contributed_extension, linestyle=2, color=color_contributed
oplot, year(baseline:*), outreach_fit, color=0
oplot, year(baseline:*), invited_fit, color=color_invited
oplot, year(baseline:*), invited_fit+contributed_fit, color=color_contributed
oplot, future, outreach_prediction, linestyle=3, color=0
oplot, future, invited_prediction, linestyle=3, color=color_invited
oplot, future, invited_prediction+contributed_prediction, linestyle=3, color=color_contributed
; labels
xyouts, thesis+first_year - 0.25, limit - 5, 'Thesis', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, dissertation+first_year - 0.25, limit - 5, 'Dissertation', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, postdoc+first_year - 0.25, limit - 5, 'Postdoc', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, postdoc+first_year + 1., limit - 5, 'Hired as RO at NRC', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, continuing+first_year + 1., limit - 5, 'Continuing, Staff', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, covid+first_year + 1., limit - 5, 'Pandemic', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, retirement+first_year + 1., limit - 5, 'Retirement', alignment=1., orientation=90., charsize=charsize_text, color=0
xyouts, last_year - 1.75, invited(last_year-first_year) - 10, 'Invited', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, invited(last_year-first_year)+contributed(last_year-first_year) - 10, 'Including', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, invited(last_year-first_year)+contributed(last_year-first_year) - 15, 'contributed', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, outreach(last_year-first_year) - 15, 'Total, incl.', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, outreach(last_year-first_year) - 20, 'interviews,', alignment=0., orientation=0., charsize=charsize_text, color=0
xyouts, last_year - 1.75, outreach(last_year-first_year) - 25, 'other media', alignment=0., orientation=0., charsize=charsize_text, color=0
; clean up
axis, xaxis=0, color=0, xstyle=1, xrange=[first_year-1,last_year+5], charsize=charsize
axis, xaxis=1, color=0, xstyle=1, xrange=[first_year-1,last_year+5], xtickformat='(A1)'
axis, yaxis=0, color=0, ystyle=1, yrange=[0., limit], charsize=charsize
axis, yaxis=1, color=0, ystyle=1, yrange=[0., limit], ytickformat='(A1)'

; save a screen capture
screen_output=tvrd(true=1)
write_jpeg, 'plot_reformat.jpg', screen_output, quality=100, true=1

end
