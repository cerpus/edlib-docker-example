#!/bin/sh
set -e

startup.sh

if [ ! -f "storage/app/first-time-setup-completed" ]; then
  # Pre-install libraries
  php artisan h5p:library-hub-cache
  php artisan h5p:library-install \
      H5P.Accordion \
      H5P.Audio \
      H5P.AudioRecorder \
      H5P.Blanks \
      H5P.CoursePresentation \
      H5P.Dialogcards \
      H5P.DocumentationTool \
      H5P.DragQuestion \
      H5P.DragText \
      H5P.Flashcards \
      H5P.GuessTheAnswer \
      H5P.IFrameEmbed \
      H5P.ImageHotspotQuestion \
      H5P.ImageHotspots \
      H5P.InteractiveVideo \
      H5P.MarkTheWords \
      H5P.MemoryGame \
      H5P.MultiChoice \
      H5P.MultiMediaChoice \
      H5P.QuestionSet \
      H5P.Questionnaire \
      H5P.SingleChoiceSet \
      H5P.Summary \
      H5P.Timeline \
      H5P.TrueFalse

  touch storage/app/first-time-setup-completed
fi
