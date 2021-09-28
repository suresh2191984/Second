using System;
using System.Collections.Generic;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

namespace Attune
{
    public static class PdfMerger
    {
        /// <summary>
        /// Merge pdf files.
        /// </summary>
        /// <param name="sourceFiles">PDF files being merged.</param>
        /// <returns></returns>
        public static byte[] MergeFiles(List<byte[]> sourceFiles, bool isCustomPageNumberRequired, int OrgID)
        {
            Document document = new Document();
            MemoryStream output = new MemoryStream();
            try
            {
                try
                {
                    // Initialize pdf writer
                    PdfWriter writer = PdfWriter.GetInstance(document, output);

                    if (isCustomPageNumberRequired)
                    {
                        int totalNoOfPages = 0;
                        for (int index = 0; index < sourceFiles.Count; index++)
                        {
                            PdfReader reader = new PdfReader(sourceFiles[index]);
                            totalNoOfPages = totalNoOfPages + reader.NumberOfPages;
                        }
                        writer.PageEvent = new PdfPageEvents(totalNoOfPages,OrgID);
                    }

                    // Open document to write
                    document.Open();
                    PdfContentByte content = writer.DirectContent;

                    // Iterate through all pdf documents
                    for (int fileCounter = 0; fileCounter < sourceFiles.Count; fileCounter++)
                    {
                        // Create pdf reader
                        PdfReader reader = new PdfReader(sourceFiles[fileCounter]);
                        int numberOfPages = reader.NumberOfPages;

                        // Iterate through all pages
                        for (int currentPageIndex = 1; currentPageIndex <= numberOfPages; currentPageIndex++)
                        {
                            // Determine page size for the current page
                            document.SetPageSize(reader.GetPageSizeWithRotation(currentPageIndex));
                            // Create page
                            document.NewPage();
                            PdfImportedPage importedPage = writer.GetImportedPage(reader, currentPageIndex);
                            // Determine page orientation
                            int pageOrientation = reader.GetPageRotation(currentPageIndex);
                            if ((pageOrientation == 90) || (pageOrientation == 270))
                            {
                                content.AddTemplate(importedPage, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(currentPageIndex).Height);
                            }
                            else
                            {
                                content.AddTemplate(importedPage, 1f, 0, 0, 1f, 0, 0);
                            }
                        }
                    }
                }
                catch (Exception exception)
                {
                    throw new Exception("There has an unexpected exception occured during the pdf merging process.", exception);
                }
            }
            finally
            {
                document.Close();
            }
            return output.GetBuffer();
        }
        public static byte[] ReprintMergeFiles(byte[] sourceFiles, bool Flag, int MoveX, int MoveY, int LineX, int LineY, int FontSize, string ReportType)
        {
            Document document = new Document();
            MemoryStream output = new MemoryStream();
            try
            {
                try
                {
                    // Initialize pdf writer
                    PdfWriter writer = PdfWriter.GetInstance(document, output);
                    int totalNoOfPages = 0;
                    PdfReader reader = null;


                    reader = new PdfReader(sourceFiles);
                    totalNoOfPages = totalNoOfPages + reader.NumberOfPages;

                    writer.PageEvent = new PdfMergePageEvents(totalNoOfPages, Flag, MoveX, MoveY, LineX, LineY, FontSize,ReportType);
                    // Open document to write
                    document.Open();
                    PdfContentByte content = writer.DirectContent;

                    // Iterate through all pdf documents

                    // Iterate through all pages
                    for (int currentPageIndex = 1; currentPageIndex <= totalNoOfPages; currentPageIndex++)
                    {
                        // Determine page size for the current page
                        document.SetPageSize(reader.GetPageSizeWithRotation(currentPageIndex));
                        // Create page
                        document.NewPage();
                        PdfImportedPage importedPage = writer.GetImportedPage(reader, currentPageIndex);
                        // Determine page orientation
                        int pageOrientation = reader.GetPageRotation(currentPageIndex);
                        if ((pageOrientation == 90) || (pageOrientation == 270))
                        {
                            content.AddTemplate(importedPage, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(currentPageIndex).Height);
                        }
                        else
                        {
                            content.AddTemplate(importedPage, 1f, 0, 0, 1f, 0, 0);
                        }
                    }
                }
                catch (Exception exception)
                {
                    throw new Exception("There has an unexpected exception occured during the pdf merging process.", exception);
                }
            }
            finally
            {
                document.Close();
            }
            return output.GetBuffer();
        }
         public static byte[] ReprintMergeFiles(List<byte[]> sourceFiles, bool isCustomPageNumberRequired, int MoveX,int MoveY,int LineX, int LineY, int FontSize,string ReportType)
        {
            Document document = new Document();
            MemoryStream output = new MemoryStream();
            try
            {
                try
                {
                    // Initialize pdf writer
                    PdfWriter writer = PdfWriter.GetInstance(document, output);

                    if (isCustomPageNumberRequired)
                    {
                        int totalNoOfPages = 0;
                        for (int index = 0; index < sourceFiles.Count; index++)
                        {
                            PdfReader reader = new PdfReader(sourceFiles[index]);
                            totalNoOfPages = totalNoOfPages + reader.NumberOfPages;
                        }
                        writer.PageEvent = new PdfMergePageEvents(totalNoOfPages, isCustomPageNumberRequired,MoveX,MoveY,LineX,LineY,FontSize,ReportType);
                    }

                    // Open document to write
                    document.Open();
                    PdfContentByte content = writer.DirectContent;

                    // Iterate through all pdf documents
                    for (int fileCounter = 0; fileCounter < sourceFiles.Count; fileCounter++)
                    {
                        // Create pdf reader
                        PdfReader reader = new PdfReader(sourceFiles[fileCounter]);
                        int numberOfPages = reader.NumberOfPages;

                        // Iterate through all pages
                        for (int currentPageIndex = 1; currentPageIndex <= numberOfPages; currentPageIndex++)
                        {
                            // Determine page size for the current page
                            document.SetPageSize(reader.GetPageSizeWithRotation(currentPageIndex));
                            // Create page
                            document.NewPage();
                            PdfImportedPage importedPage = writer.GetImportedPage(reader, currentPageIndex);
                            // Determine page orientation
                            int pageOrientation = reader.GetPageRotation(currentPageIndex);
                            if ((pageOrientation == 90) || (pageOrientation == 270))
                            {
                                content.AddTemplate(importedPage, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(currentPageIndex).Height);
                            }
                            else
                            {
                                content.AddTemplate(importedPage, 1f, 0, 0, 1f, 0, 0);
                            }
                        }
                    }
                }
                catch (Exception exception)
                {
                    throw new Exception("There has an unexpected exception occured during the pdf merging process.", exception);
                }
            }
            finally
            {
                document.Close();
            }
            return output.GetBuffer();
        }
    }

    /// <summary>
    /// Implements custom page events.
    /// </summary>
    internal class PdfPageEvents : IPdfPageEvent
    {
        #region members

        private BaseFont _baseFont = null;
        private PdfContentByte _content;
        private int _totalNoOfPages = 0;
        private int _orgID = 0;
        #endregion

        #region IPdfPageEvent Members

        public PdfPageEvents(int totalNoOfPages,int OrgID)
        {
            _totalNoOfPages = totalNoOfPages;
            _orgID = OrgID;
        }

        public void OnOpenDocument(PdfWriter writer, Document document)
        {
            _baseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            _content = writer.DirectContent;
        }

        public void OnStartPage(PdfWriter writer, Document document)
        {
        }

        public void OnEndPage(PdfWriter writer, Document document)
        {
            // Write header text
            //string headerText = "";
            //_content.BeginText();
            //_content.SetFontAndSize(_baseFont, 8);
            //_content.SetTextMatrix(GetCenterTextPosition(headerText, writer), writer.PageSize.Height - 10);
            //_content.ShowText(headerText);
            //_content.EndText();

            // Write footer text (page numbers)
            string text = "Page " + writer.PageNumber + " of " + _totalNoOfPages;
            _content.BeginText();
            _content.SetFontAndSize(_baseFont, 10);
            string PageNumberInRightSide = string.Empty;
            PageNumberInRightSide = "N";
            string PageNumberInTopRightSide = string.Empty;
            PageNumberInTopRightSide = "N";
            long returnCode = -1;
            List<Config> lstConfig = new List<Config>();
            returnCode = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("DisplayPageNumberInRightSide", _orgID, out lstConfig);
            long returnCode1 = -1;
            List<Config> lstConfigForPageNo = new List<Config>();
            returnCode1 = new GateWay(new BaseClass().ContextInfo).GetConfigDetails("DisplayPageNumberInTopRightSide", _orgID, out lstConfigForPageNo);

            if (lstConfig != null)
            {
                if (lstConfig.Count > 0)
                {
                    PageNumberInRightSide = lstConfig[0].ConfigValue;
                }
            }
            if (lstConfigForPageNo != null)
            {
                if (lstConfigForPageNo.Count > 0)
                {
                    PageNumberInTopRightSide = lstConfigForPageNo[0].ConfigValue;
                }
            }
            if (PageNumberInTopRightSide == "Y")
            {
                _content.SetFontAndSize(_baseFont, 7);
                _content.SetTextMatrix(GetRightTextPosition(text, writer), writer.PageSize.Height - 20);
                //_content.SetTextMatrix(GetCenterTextPosition(text, writer), writer.PageSize.Height - 10);
            }
            else
            {
                if (PageNumberInRightSide == "Y")
                {
                    _content.SetTextMatrix(GetRightTextPosition(text, writer), 10);
                }
                else
                {
                    _content.SetTextMatrix(GetCenterTextPosition(text, writer), 70);
                }

            } 
            _content.ShowText(text);
            _content.EndText();
        }

        public void OnCloseDocument(PdfWriter writer, Document document)
        {
        }

        public void OnParagraph(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnParagraphEnd(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title)
        {
        }

        public void OnChapterEnd(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title)
        {
        }

        public void OnSectionEnd(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnGenericTag(PdfWriter writer, Document document, Rectangle rect, string text)
        {
        }

        #endregion

        private float GetCenterTextPosition(string text, PdfWriter writer)
        {
            return writer.PageSize.Width / 2 - _baseFont.GetWidthPoint(text, 8) / 2;
        }
        private float GetRightTextPosition(string text, PdfWriter writer)
        {
            return writer.PageSize.Width - 50 - _baseFont.GetWidthPoint(text, 8) / 4;
        }
	}
    internal class PdfMergePageEvents : IPdfPageEvent
    {
        #region members

        private BaseFont _baseFont = null;
        private PdfContentByte _content;
        private int _totalNoOfPages = 0;
        private bool _flag = false;
        private int _movex = 0;
        private int _movey = 0;
        private int _linex = 0;
        private int _liney = 0;
        private int _fontsize = 0;
        private string _ReportType = string.Empty;
        #endregion

        #region IPdfPageEvent Members

        public PdfMergePageEvents(int totalNoOfPages, bool flag,int MoveX,int MoveY,int LineX,int LineY,int FontSize,string ReportType)
        {
            _totalNoOfPages = totalNoOfPages;
            _flag = flag;
            _movex = MoveX;
            _movey = MoveY;
            _linex = LineX;
            _liney = LineY;
            _fontsize = FontSize;
            _ReportType = ReportType;


        }

        public void OnOpenDocument(PdfWriter writer, Document document)
        {
            _baseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            _content = writer.DirectContent;
        }

        public void OnStartPage(PdfWriter writer, Document document)
        {
        }

        public void OnEndPage(PdfWriter writer, Document document)
        {
            // Write header text
            //string headerText = "";
            //_content.BeginText();
            //_content.SetFontAndSize(_baseFont, 8);
            //_content.SetTextMatrix(GetCenterTextPosition(headerText, writer), writer.PageSize.Height - 10);
            //_content.ShowText(headerText);
            //_content.EndText();

            // Write footer text (page numbers)
            string text = string.Empty;
            if (_flag == true && _ReportType == "Final" )
            {
                text = "** Electronically Signed-off report* Duplicate " + DateTime.Now.ToString();
            }
            else if (_flag == false && _ReportType == "Final")
            {
                text = "** Electronically Signed-off report* Original " + DateTime.Now.ToString();
            }
            else
            {
                text = "";
            }

            _content.MoveTo((writer.PageSize.Width / 4) - _movex, _movey);
            _content.LineTo((writer.PageSize.Width) - _linex, _liney);
            _content.Stroke();
            _content.BeginText();
            _content.SetFontAndSize(_baseFont, _fontsize);
            _content.SetTextMatrix(GetRightTextPosition(text, writer), 10);
            _content.ShowText(text);
            _content.EndText();
        }

        private float GetRightTextPosition(string text, PdfWriter writer)
        {
            return writer.PageSize.Width - 130 - _baseFont.GetWidthPoint(text, 8);
        }

        public void OnCloseDocument(PdfWriter writer, Document document)
        {
        }

        public void OnParagraph(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnParagraphEnd(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title)
        {
        }

        public void OnChapterEnd(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title)
        {
        }

        public void OnSectionEnd(PdfWriter writer, Document document, float paragraphPosition)
        {
        }

        public void OnGenericTag(PdfWriter writer, Document document, Rectangle rect, string text)
        {
        }

        #endregion

        private float GetCenterTextPosition(string text, PdfWriter writer)
        {
            return writer.PageSize.Width / 2 - _baseFont.GetWidthPoint(text, 8) / 2;
        }
    }
}